#!/bin/bash

user=$(whoami)

sudo apt-get update && sudo apt-get install -y \
    apt-transport-https \
    bat \
    bind9-dnsutils \
    binutils \
    btop \
    curl \
    fd-find \
    fzf \
    git \
    gpg \
    jq \
    net-tools \
    nmap \
    silversearcher-ag \
    tmux \
    tree \
    unrar-free \
    vagrant \
    vim \
    whois \
    xxd \
    xz-utils \
    zip \
    unzip \

# Config files
mkdir -p ~/.config/bat/themes
mkdir -p ~/.config/btop/themes
mkdir -p ~/.config/fzf/
mkdir -p ~/.config/scripts
mkdir -p ~/.config/vim/{autoload,colors}

cp config/bash/bash_aliases ~/.bash_aliases
cp config/bash/bash_functions ~/.bash_functions
cp config/bash/bashrc ~/.bashrc
cp config/bat/config ~/.config/bat/
cp config/bat/config/themes/* ~/.config/bat/themes/
cp config/btop/themes/* ~/.config/btop/themes/
cp config/fzf/*.bash ~/.config/fzf/
cp config/nano/nanorc ~/.nanorc
cp config/scripts/* ~/.config/scripts/
chmod u+x ~/.config/scripts/*.sh
cp config/tmux/tmux.conf ~/.tmux.conf
cp config/vim/vimrc ~/.config/vim/vimrc
cp config/vim/colors/*.vim ~/.config/vim/colors/
ln -s ~/.config/vim ~/.vim
ln -s ~/.config/vim/vimrc ~/.vimrc

# Install Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Tailscale
curl -fsSL https://pkgs.tailscale.com/stable/debian/$(. /etc/os-release && echo "$VERSION_CODENAME").noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/$(. /etc/os-release && echo "$VERSION_CODENAME").tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update
sudo apt-get install -y tailscale

# Groups
sudo usermod -aG docker $user
