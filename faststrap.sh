#!/bin/bash
# =============================================================================
#  __      __________   ______
# /  \    /  \_____  \ /  __  \
# \   \/\/   //  ____/ >      <
#  \        //       \/   --   \
#   \__/\  / \_______ \______  /
#        \/          \/      \/
# faststrap.sh --- Fast bootstrapping script
# Copyright (c) 2021-present Sourajyoti Basak
# Author: Sourajyoti Basak <wiz28@protonmail.com>
# URL: https://github.com/wizard-28/dotfiles/
# License: MIT
# =============================================================================

PERSISTENT_STORAGE_LOCATION="/run/media/liveuser/SBASAK"

# =============================================================================
# Functions
# =============================================================================
stage() {
    echo -e "\n$(tput bold)[\e[32mSTAGE\e[0m$(tput bold)]$(tput sgr0) $1"
}

info() {
    echo -e "$(tput bold)[\e[34mINFO\e[0m$(tput bold)]$(tput sgr0) $1"
}
# =============================================================================

# =============================================================================
# Banner
# =============================================================================
tput bold
printf '    _________   __________________________  ___    ____
   / ____/   | / ___/_  __/ ___/_  __/ __ \/   |  / __ \
  / /_  / /| | \__ \ / /  \__ \ / / / /_/ / /| | / /_/ /
 / __/ / ___ |___/ // /  ___/ // / / _, _/ ___ |/ ____/
/_/   /_/  |_/____//_/  /____//_/ /_/ |_/_/  |_/_/
'
tput sgr0
# =============================================================================

# =============================================================================
# Stage 1: Pre-configurations
# =============================================================================
stage "Starting pre-configurations..."

info "Configuring timezone"
sudo timedatectl set-timezone Asia/Kolkata &

info "Setting up SysRq"
sudo sysctl -w kernel.sysrq=1 > /dev/null &

info "Optimizing DNF"
echo "fastestmirror=1
max_parallel_downloads=10" | sudo tee -a /etc/dnf/dnf.conf > /dev/null

info "Adding extra repos"
sudo rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3
sudo dnf config-manager --add-repo https://rpm.librewolf.net
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y

info "Installing configuration files"
sudo dnf install --refresh lndir -y
(
    mkdir -p ~/.doom.d/ ~/.weechat/ ~/.librewolf/
    lndir -silent ~/dotfiles/.config/ ~/.config/
    lndir -silent ~/dotfiles/.doom.d/ ~/.doom.d/
    lndir -silent ~/dotfiles/.weechat/ ~/.weechat/
    ln -sf ~/dotfiles/.bashrc ~/.bashrc
    ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
    ln -sf ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml
    ln -sf ~/dotfiles/.azotebg ~/.azotebg
    ln -sf ~/dotfiles/.librewolf/librewolf.overrides.cfg ~/.librewolf/librewolf.overrides.cfg
) &

info "Configuring environment variables"
echo 'EDITOR="nvim"
MOZ_ENABLE_WAYLAND=1' | sudo tee -a /etc/environment > /dev/null &
# =============================================================================

# =============================================================================
# Stage 2: Install applications
# =============================================================================

info "Installing DNF applications"
sudo dnf install --setopt=install_weak_deps=False -y \
    librewolf bemenu git-delta \
    bat exa ripgrep fd-find fzf zoxide \
    libnotify jq light playerctl htop \
    libseat swaybg swayidle wlr-randr azote swaylock clipman grimshot dunst \
    https://ftp.lysator.liu.se/pub/opensuse/tumbleweed/repo/oss/x86_64/libxcb-errors0-1.0-1.25.x86_64.rpm \
    waybar fontawesome-fonts \
    ShellCheck \
    alacritty \
    fish \
    neovim gcc-c++ npm \
    python3-pip

info "Installing PIP applications"
sudo pip3 install \
    pynvim black \
    cmake > /dev/null &

info "Installing CURL applications"

# Fonts
(
    sudo mkdir -p /usr/share/fonts/jetbrainsmononl-nerd-font
    sudo curl -sfLo "/usr/share/fonts/jetbrainsmononl-nerd-font/JetBrains Mono NL Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20NL%20Regular%20Nerd%20Font%20Complete.ttf
    sudo curl -sfLo "/usr/share/fonts/jetbrainsmononl-nerd-font/JetBrains Mono NL Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20NL%20Italic%20Nerd%20Font%20Complete.ttf
    fc-cache -f
) &

(
    mkdir /tmp/faststrap/
    cd /tmp/faststrap/ || exit

    curl -s https://api.github.com/repos/vaxerski/Hyprland/releases/latest \
    | jq ".assets[0].browser_download_url" \
    | cut -d '"' -f 2 \
    | wget -qi -
    tar -xf ./*.tar.gz > /dev/null

    sudo mv Hyprland /usr/bin/
    sudo mv hyprctl /usr/bin
    sudo mv lib* /usr/lib64
    sudo mv example/hyprland.desktop /usr/share/wayland-sessions/

    cd ../ && sudo rm -rf faststrap
) &

curl -sSL https://install.python-poetry.org | python3 - > /dev/null &

notify-send --urgency critical "Interaction required"
curl -fsSL https://starship.rs/install.sh | sudo sh
# =============================================================================

# =============================================================================
# Stage 3: Purge bloat
# =============================================================================
stage "Purging bloat..."
sudo dnf remove firefox libreoffice* -y &
# =============================================================================

# =============================================================================
# Stage 4: Postconfigurations
# =============================================================================
stage "Starting postconfigurations..."

info "Changing default shell"
(
    yes "$(cat ${PERSISTENT_STORAGE_LOCATION}/passwd)" | sudo passwd "$(logname)" > /dev/null 2>&1
    yes "$(cat ${PERSISTENT_STORAGE_LOCATION}/passwd)" | chsh -s /usr/bin/fish > /dev/null 2>&1
) &

info "Setting up git"
(
    # Setup remote
    cd ~/dotfiles || exit
    git remote set-url origin git@github.com:wizard-28/dotfiles.git
) &

info "Setting up SSH and GPG keys"
sudo cp -r "${PERSISTENT_STORAGE_LOCATION}/.ssh/" ~
sudo chown "$USER":"$USER" ~/.ssh/id_ed25519*
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
eval "$(ssh-agent)" > /dev/null

notify-send "Enter password for SSH and GPG key"
ssh-add ~/.ssh/id_ed25519
wl-copy < "${PERSISTENT_STORAGE_LOCATION}/GPG.txt"
gpg --import "${PERSISTENT_STORAGE_LOCATION}/GPG.asc"

wait
# =============================================================================
# Finish up
# =============================================================================
notify-send --urgency critical "Logging out in 10 secs"
sleep 10
sudo service gdm3 stop
# =============================================================================
