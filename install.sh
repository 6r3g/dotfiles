#!/bin/bash

sudo apt update && sudo apt upgrade -y

# install packages
sudo apt install -y i3-gaps i3-wm picom rofi polybar fonts-font-awesome
sudo apt install -y arandr flameshot feh unclutter imagemagick bpytop htop neofetch code-oss glxinfo 

# install apps

# Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip
sudo unzip Iosevka.zip -d /usr/share/fonts/
sudo unzip RobotoMono.zip -d /usr/share/fonts/
fc-cache -fv

# Alacritty
wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.1-1/alacritty_0.10.1-1_amd64_bullseye.deb
sudo dpkg -i alacritty_0.10.1-1_amd64_bullseye.deb
sudo apt install -f

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
cp .config/.zshrc ~/


# dotfiles
mkdir -p ~/.config/i3
mkdir -p ~/.config/picom
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/polybar
mkdir -p ~/.config/wallpaper
cp -r config/i3/ ~/.config/i3/
cp config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp config/picom/picom.conf ~/.config/picom/picom.conf
cp -r config/rofi/ ~/.config/rofi/
cp -r config/polybar/* ~/.config/polybar/
cp config/wallpaper/wallpaper.jpg ~/.config/wallpaper/
