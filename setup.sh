#!/bin/bash

defaultBrowser="firefox"

# Color functions
function error() {
  echo -e "\e[91m${1}\e[0m"
}

function process() {
  echo -e "\e[93m${1}\e[0m"
}

function checkpoint() {
  echo -e "\e[42m\e[97m${1}\e[0m"
}

function success() {
	if [ $? -eq 0 ]; then
		echo -e "\e[92m${1} successfully! \e[0m"
	else
		error "Error occurred while ${2}!"
	fi
}

checkpoint "Starting preconfigurations..."
# Timezone and sources changes
process "Changing the timezone to Asia/Kolkata..."
sudo timedatectl set-timezone Asia/Kolkata
success "Timezone changed" "changing timezone"

# Update apt-get sources
process "Changing the apt-get sources to the fastest ones..."
sudo echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-security main restricted universe multiverse
deb cdrom:[Pop_OS 20.04 _Focal Fossa_ - Release amd64 (20200702)]/ focal main restricted
deb http://apt.pop-os.org/proprietary focal main" | sudo tee /etc/apt/sources.list > /dev/null
success "Sources updated" "updating sources"

# Update sources
process "Updating apt-get sources..."
sudo apt-get update > /dev/null
success "Sources updated" "updating the sources"

# Update apt
process "Updating apt..."
sudo apt-get install apt -y > /dev/null
success "Apt updated" "updating apt"

# Install lndir
process "Install lndir and install all configuration files"
sudo apt-get install xutils-dev -y > /dev/null
mkdir -p ~/.doom.d ~/.weechat ~/.SpaceVim.d
lndir -silent ~/dotfiles/.config/ ~/.config/
lndir -silent ~/dotfiles/.doom.d/ ~/.doom.d/
lndir -silent ~/dotfiles/.weechat/ ~/.weechat/
lndir -silent ~/dotfiles/.SpaceVim.d/ ~/.SpaceVim.d/
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml
success "Installed lndir and all configuration files" "installing lndir and all configuration files"

checkpoint "Proceeding with browser installation..."
# Install firefox
if [ $defaultBrowser = "firefox" ]; then
	process "Installing firefox..."
	sudo apt-get install firefox -y > /dev/null
	success "Firefox installed" " installing firefox"
fi

# Install brave
if [ $defaultBrowser = "brave" ]; then
	process "Installing dependencies for brave..."
	sudo apt-get install apt-transport-https curl gnupg -y > /dev/null
	success "Dependencies for brave installed" "installing dependencies for brave"
	
	process "Installing brave signing key..."
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - > /dev/null
	success "Brave signing key installed" "installing brave signing key"

	process "Adding brave repository..."
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
	success "Brave repository added" "adding brave repository"
	
	process "Updating sources..."
	sudo apt-get update > /dev/null
	success "Sources updated" "updating the sources"

	process "Installing brave..."
	sudo apt-get install brave-browser -y > /dev/null
	success "Brave installed" "installing brave"
fi


# Purge bloat
checkpoint "Proceeding with bloat purge..."
if [ $defaultBrowser = "brave" ]; then
	# Purge firefox as brave is installed
	process "Purging firefox..."
	sudo apt-get purge firefox -y > /dev/null
	success "Purged firefox" "purging firefox"
fi

# Purge libreoffice
process "Purging libreoffice..."
sudo apt-get purge libreoffice-common -y > /dev/null
success "Purged libreoffice" "purging libreoffice"

# Autoremove and purge
process "Cleaning up..."
sudo apt-get autoremove --purge -y > /dev/null
success "Cleaned up" "cleaning up"

# Install QOL programs
process "Installing QOL programs..."
# HACK: work-around for https://github.com/sharkdp/bat/issues/938
sudo apt-get install -o Dpkg::Options::="--force-overwrite" lua5.3 bat ripgrep fd-find fzf zram-config zram-tools gnome-tweaks gstreamer1.0-plugins-bad -y > /dev/null
sudo swapoff -a > /dev/null
sudo zramctl /dev/zram0 --size 750M > /dev/null
sudo zramctl /dev/zram1 --size 750M > /dev/null
sudo zramctl /dev/zram2 --size 750M > /dev/null
sudo zramctl /dev/zram3 --size 750M > /dev/null
sudo zramswap start > /dev/null
sudo sysctl -w kernel.sysrq=1
sudo curl -sfLo "/bin/z" https://raw.githubusercontent.com/skywind3000/z.lua/master/z.lua 
sudo chmod +x /bin/z
success "Installed QOL programs" "installing QOL programs"

checkpoint "Proceeding with window manager installation and configuring them"
# Install dependencies for swaywm
process "Installing dependencies for swaywm"
sudo add-apt-repository ppa:nschloe/sway-backports -y > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install libnotify-bin jq light grim slurp playerctl htop wl-clipboard mako-notifier xwayland libgdk-pixbuf2.0-common libgdk-pixbuf2.0-bin gir1.2-gdkpixbuf-2.0 python3-pip -y > /dev/null
sudo curl -sfLo "/home/pop-os/.local/bin/grimshot" https://raw.githubusercontent.com/swaywm/sway/master/contrib/grimshot
sudo chmod +x .local/bin/grimshot
pip3 install autotiling > /dev/null
sudo echo -e 'EDITOR="nvim"\nMOZ_ENABLE_WAYLAND=1' | sudo tee -a /etc/environment > /dev/null
success "Installed dependencies for swaywm" "installing dependencies for swaywm"

# Install swaywm
process "Installing swaywm..."
sudo apt-get install sway swayidle sway-backgrounds -y > /dev/null
success "Swaywm installed" "installing swaywm"

# Install swaylock-effects
process "Installing swaylock-effects..."
sudo cp /media/pop-os/S\ BASAK/swaylock /usr/local/bin/
sudo chmod a+x+s /usr/local/bin/swaylock
success "Installed swaylock-effects" "installing swaylock-effects"

# Install waybar
process "Installing waybar..."
sudo add-apt-repository ppa:nschloe/waybar -y > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install waybar -y > /dev/null
success "Waybar installed" "installing waybar"
# Install fonts
process "Installing fonts for waybar..."
sudo apt-get install fonts-font-awesome -y > /dev/null
fc-cache -f -v > /dev/null
success "Fonts installed for waybar" "installing fonts for waybar"


checkpoint "Proceeding with programming utility installation..."
# Install node
process "Installing node..."
curl -sL install-node.now.sh/lts | sudo bash
success "Node installed" "installing node"

# Install shellcheck
process "Installing shellcheck..."
sudo apt-get install shellcheck -y > /dev/null
success "Shellcheck installed" "installing shellcheck"

# Install python utils
process "Installing python utils..."
sudo pip3 install pynvim black pipenv > /dev/null
success "Python utils installed" "installing python utils"

# Install alacritty
process "Installing alacritty..."
sudo apt-get install alacritty -y > /dev/null
success "Alacritty installed" "installing alacritty"
# Install fonts for alacritty
process "Installing JetBrains NL Mono Nerd Font for alacritty..."
sudo curl -sfLo "/usr/share/fonts/truetype/JetBrains Mono NL Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20NL%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
sudo curl -sfLo "/usr/share/fonts/truetype/JetBrains Mono NL Italic Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20NL%20Italic%20Nerd%20Font%20Complete%20Mono.ttf
success "Installed JetBrains NL Mono Nerd Font for alacritty" "installing JetBrains NL Mono Nerd Font for alacritty"
# Install fish
process "Installing fish..."
sudo apt-add-repository ppa:fish-shell/release-3 -y > /dev/null
sudo apt-get update -y > /dev/null
sudo apt-get install fish -y > /dev/null
chsh -s /usr/bin/fish
success "Installed fish" "installing fish"

# Install starship
process "Installing starship..."
yes y | sudo sh -c "$(curl -fsSL https://starship.rs/install.sh)"
success "Installed starship" "installing starship"

# Install neovim
process "Installing neovim..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y > /dev/null
sudo apt-get update -y > /dev/null
sudo apt-get install neovim -y > /dev/null
success "Installed neovim" "installing neovim"

# Install pacstall
process "Installing pacstall..."
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
success "Installed pacstall" "installing pacstall"

# Install neofetch
process "Installing neofetch..."
sudo pacstall -P -I fastfetch-git > /dev/null
success "Installed neofetch" "installing neofetch"

# Install bemenu
process "Installing bemenu..."
yes 2 | sudo pacstall -P -I bemenu-git > /dev/null
success "Installed bemenu" "installing bemenu"
# Purge dmenu
process "Purging dmenu..."
sudo apt-get purge suckless-tools -y > /dev/null
success "Purged dmenu" "purging dmenu"

# Install exa
process "Installing exa..."
(
mkdir exa/
cd exa/ || exit
curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep "browser_download_url" | grep "exa-linux-x86_64-v" | cut -d '"' -f 4 | wget -qi -
unzip -q exa*
sudo mv bin/exa /usr/local/bin
sudo mv man/exa.1 /usr/share/man/man1/
sudo mv completions/exa.fish /usr/share/fish/vendor_completions.d/
sudo mv completions/exa.bash /etc/bash_completion.d/
)
rm -r exa/
success "Installed exa" "installing exa"

# Install clipman
process "Installing clipman..."
sudo cp /media/pop-os/S\ BASAK/clipman /bin/
sudo chmod 775 /bin/clipman
success "Installed clipman" "installing clipman"

checkpoint "Proceeding with git configuration..."
# Add SSH and GPG Keys
process "Adding SSH and GPG keys..."
sudo cp -r /media/pop-os/S\ BASAK/.ssh/ ~
sudo cp /media/pop-os/S\ BASAK/github.asc ~/github.asc
sudo chown "$USER":"$USER" ~/.ssh/id_ed25519*
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
eval "$(ssh-agent)"
ssh-add ~/.ssh/id_ed25519
gpg --import ~/github.asc
success "SSH and GPG keys added" "adding SSH and GPG Keys"

# Configure git
process "Configuring git..."
git config --global user.name "Sourajyoti Basak"
git config --global user.email "wiz28@protonmail.com"
git config --global user.signingkey BB60A61ECF3DCDDB
git config --global commit.gpgsign true
git config --global merge.conflictstyle diff3
git config --global merge.tool vim_mergetool
git config --global mergetool.vim_mergetool.cmd 'nvim -c "MergetoolStart" "$MERGED" "$BASE" "$LOCAL" "$REMOTE"'
# Aliases
git config --global alias.logline "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# Setup SSH
git remote set-url origin git@github.com:wizard-28/dotfiles.git
success "Git configured" "configuring git"


checkpoint "Proceeding with multimedia installations..."
# Install Codecs
process "Installing pipewire..."
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install libfdk-aac1 libldacbt-{abr,enc}2 libopenaptx0 -y > /dev/null
sudo apt-get install gstreamer1.0-pipewire libpipewire-0.3-{0,dev,modules} libspa-0.2-{bluetooth,dev,jack,modules} pipewire{,-{audio-client-libraries,bin,locales,tests}} -y > /dev/null
systemctl --user --now disable  pulseaudio.{socket,service} > /dev/null
systemctl --user mask pulseaudio > /dev/null
systemctl --user --now enable pipewire{,-pulse}{.socket,.service} pipewire-media-session.service > /dev/null
success "Pipewire installed" "installing pipewire"

checkpoint "Setup complete. Enjoy your laptop now! "
