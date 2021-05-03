#!/bin/bash

defaultBrowser="brave"

# Color functions
error() {
  echo "\e[91m${1}\e[0m"
}

process() {
  echo "\e[93m${1}\e[0m"
}

checkpoint() {
  echo "\e[42m\e[97m${1}\e[0m"
}

success() {
	if [ $? -eq 0 ]; then
		echo "\e[92m${1} successfully!\e[0m"
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

checkpoint "Proceeding with window manager installation and configuring them"
# Install dependencies for swaywm
process "Installing dependencies for swaywm"
sudo add-apt-repository ppa:nschloe/sway-backports -y > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install light grim slurp htop wl-clipboard mako-notifier xwayland libgdk-pixbuf2.0-common libgdk-pixbuf2.0-bin gir1.2-gdkpixbuf-2.0 python3-pip -y > /dev/null
pip3 install autotiling > /dev/null
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


# Install configuration files
process "Installing configuration..."
# Make the directories
mkdir ~/.config/sway/ ~/.config/swaylock/ ~/.config/waybar/ ~/.config/waybar/modules ~/.config/sway/scripts
# sway
ln -sf ~/dotfiles/.config/sway/config ~/.config/sway/config
ln -sf ~/dotfiles/.config/swaylock/config ~/.config/swaylock/config
ln -sf ~/dotfiles/.config/sway/scripts/fibonacci.py ~/.config/sway/scripts/fibonacci.py
ln -sf ~/dotfiles/.config/sway/nick-nazzaro-ice-cave.jpg ~/.config/sway/nick-nazzaro-ice-cave.jpg

# waybar
ln -sf ~/dotfiles/.config/waybar/config ~/.config/waybar/config
ln -sf ~/dotfiles/.config/waybar/style.css ~/.config/waybar/style.css
ln -sf ~/dotfiles/.config/waybar/modules/waybar-wttr.py ~/.config/waybar/modules/waybar-wttr.py

# bashrc
ln -sf ~/dotfiles/.bashrc ~/.bashrc
success "Configuration files installed" "installing configuration files"


checkpoint "Proceeding with programming utility installation and configuring them..."
# Install shellcheck
process "Installing shellcheck..."
sudo apt-get install shellcheck -y > /dev/null
success "Shellcheck installed" "installing shellcheck"

# Install alacritty
process "Installing and configuring alacritty..."
sudo apt-get install alacritty -y > /dev/null
ln -sf ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty.yml
success "Alacritty installed and configured" "installing and configuring alacritty"

# Install neofetch
process "Installing neofetch..."
sudo apt-get install neofetch -y > /dev/null
success "Neofetch installed" "installing neofetch..."

checkpoint "Proceeding with git configuration..."
# Add SSH and GPG Keys
process "Adding SSH and GPG keys..."
sudo cp -r /media/pop-os/S\ BASAK/.ssh/ ~
sudo cp /media/pop-os/S\ BASAK/github.asc ~/github.asc
sudo chown "$USER":"$USER" ~/.ssh/id_ed25519*
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
ssh-agent bash
ssh-add ~/.ssh/id_ed25519
gpg --import ~/github.asc
success "SSH and GPG keys added" "adding SSH and GPG Keys"

# Configure git
process "Configuring git..."
git config --global user.name "Sourajyoti Basak"
git config --global user.email "basak.sb2006@gmail.com"
git config --global user.signingkey CFF8C32DEBE58AB4
git config --global commit.gpgsign true
# Setup SSH
sudo touch ~/.ssh/known_hosts
cd dotfiles
git remote set-url origin git@github.com:wizard-28/dotfiles.git
cd ..
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


checkpoint "Setup complete. Enjoy your laptop now!"
