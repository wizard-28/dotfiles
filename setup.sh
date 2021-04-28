#!/bin/sh

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
# Install swaywm
process "Installing swaywm..."
sudo apt-get install sway swaylock swayidle -y > /dev/null
success "Swaywm installed" "installing swaywm"
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
process "Installing configuration files for swaywm and waybar..."
# Make the directories
mkdir ~/.config/sway/ ~/.config/waybar/
ln -sf ~/dotfiles/.config/sway/config ~/.config/sway/config
ln -sf ~/dotfiles/.config/waybar/config ~/.config/waybar/config
success "Configuration files for swaywm and waybar installed" "installing configuration files for swaywm and waybar"

checkpoint "Proceeding with programming software installations..."
# Install doom emacs dependencies
process "Installing doom emacs dependencies..."
sudo add-apt-repository ppa:kelleyk/emacs -y > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install emacs27 git ripgrep fd-find -y > /dev/null
success "Dependencies for doom emacs insatalled" "installing dependencies for doom emacs"

# Install doom emacs
process "Installing doom emacs..."
git clone --quiet --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
yes | ~/.emacs.d/bin/doom install > /dev/null
success "Doom emacs installed" "installing doom emacs"

# Install configuration files
process "Installing configuraion files for doom emacs..."
ln -sf ~/dotfiles/.doom.d/config.el ~/.doom.d/config.el
ln -sf ~/dotfiles/.doom.d/init.el ~/.doom.d/init.el
ln -sf ~/dotfiles/.doom.d/packages.el ~/.doom.d/packages.el
~/.emacs.d/bin/doom sync > /dev/null
success "Configuration files for doom emacs installed" "installing configuration files for doom emacs"


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

# Configure git
process "Configuring git..."
git config --global user.name "Sourajyoti Basak"
git config --global user.email "basak.sb2006@gmail.com"
success "Git configured" "installing programming utils"


checkpoint "Proceeding with video codecs installations..."
# Install Codecs
process "Installing codecs..."
sudo apt-get install gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y > /dev/null
success "Codecs installed" "installing codecs"

checkpoint "Setup complete. Enjoy your laptop now!"
