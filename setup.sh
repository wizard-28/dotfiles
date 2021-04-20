#!/bin/sh

# Clear any residue log files
rm -f ./.log

# Values
DB="brave" # Constant
noOfErrors=1 # Variable

# Color functions
error() {
    echo "\e[91m${1}\e[0m"
}

pass() {
    echo "\e[92m${1}\e[0m"
}

process() {
    echo "\e[93m${1}\e[0m"
}

checkpoint() {
    echo "\e[42m\e[97m${1}\e[0m"
}

success() {
	if [ $? -eq 0 ]; then
		pass "${1} successfully!"
		rm -f ./.log
	else
		cp ./.log "./error${noOfErrors}.txt"
		error "Error occurred while ${2}!"
		error "Check out the log at ./error${noOfErrors}.txt"
		noOfErrors=$((noOfErrors + 1))
	fi
}


checkpoint "Starting preconfigurations..."

# Timezone and sources changes
process "Changing the timezone to Asia/Kolkata..."
sudo timedatectl set-timezone Asia/Kolkata
pass "Successfully changed!"

# Update apt-get sources
process "Changing the apt-get sources to the fastest ones..."
sudo echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-security main restricted universe multiverse
deb cdrom:[Pop_OS 20.04 _Focal Fossa_ - Release amd64 (20200702)]/ focal main restricted
deb http://apt.pop-os.org/proprietary focal main" | sudo tee /etc/apt/sources.list > /dev/null 2>&1
pass "Successfully changed!"

# Update sources
process "Updating apt-get sources..."
sudo apt-get update | sudo tee ./.log > /dev/null 2>&1
success "Sources updated" "updating the sources"

# Update apt
process "Updating apt..."
sudo apt-get install apt -y | sudo tee ./.log > /dev/null 2>&1
success "Apt updated" "updating apt"

checkpoint "Proceeding with program installations..."

# Install firefox
if [ $DB = "firefox" ]; then
	process "Installing firefox..."
	sudo apt-get install firefox -y | sudo tee ./.log > /dev/null 2>&1
	success "Firefox installed" " installing firefox"
fi

# Install brave
if [ $DB = "brave" ]; then
	process "Installing dependencies for brave..."
	sudo apt-get install apt-transport-https curl gnupg -y | sudo tee ./.log > /dev/null 2>&1
	success "Dependencies for brave installed" "installing dependencies for brave"
	
	process "Installing brave signing key..."
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - | sudo tee ./.log > /dev/null 2>&1
	success "Brave signing key installed" "installing brave signing key"

	process "Adding brave repository..."
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list | sudo tee ./.log > /dev/null 2>&1
	success "Brave repository added" "adding brave repository"
	
	process "Updating sources..."
	sudo apt-get update | sudo tee ./.log > /dev/null 2>&1
	success "Sources updated" "updating the sources"

	process "Installing brave..."
	sudo apt-get install brave-browser -y | sudo tee ./.log > /dev/null 2>&1
	success "Brave installed" "installing brave"

	if [ "$2" != "-p" ] && [ "$2" != "--preserve" ]; then
		process "Purging firefox..."
		sudo apt-get purge firefox -y | sudo tee ./.log > /dev/null 2>&1
		success "Purged firefox" "purging firefox"
	fi

fi

# Install doom emacs
# Install dependencies
process "Installing doom emacs dependencies..."
sudo add-apt-repository ppa:kelleyk/emacs -y | sudo tee ./.log > /dev/null 2>&1
sudo apt-get update | sudo tee ./.log > /dev/null 2>&1
sudo apt-get install emacs27 git ripgrep fd-find -y | sudo tee ./.log > /dev/null 2>&1
success "Dependencies for doom emacs insatalled" "installing dependencies for doom emacs"

# Install doom emacs
process "Installing doom emacs..."
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d | sudo tee ./.log > /dev/null 2>&1
~/.emacs.d/bin/doom install
success "doom emacs installed" "installing doom emacs"

# Install configuration files
process "Installing configuraion files for doom emacs"
ln -sf ~/dotfiles/.doom.d/config.el ~/.doom.d/config.el
ln -sf ~/dotfiles/.doom.d/init.el ~/.doom.d/init.el
ln -sf ~/dotfiles/.doom.d/packages.el ~/.doom.d/packages.el
~/.emacs.d/bin/doom sync | sudo tee ./.log > /dev/null 2>&1
success "configuration files for doom emacs installed" "installing configuration files for doom emacs..."

# Install programming utils
process "Installing programming utils..."
sudo apt install shellcheck | sudo tee ./.log > /dev/null 2>&1
success "programming utils" "installing programming utils"

# Install Codecs
process "Installing codecs..."
sudo apt-get install gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y | sudo tee ./.log > /dev/null 2>&1
success "codecs installed" "installing codecs"

checkpoint "Setup complete. Enjoy your laptop now!"