#!/bin/sh

sudo apt install -y i3-gaps i3-gaps-wm i3blocks i3status compton rofi papirus-icon-theme feh lxappearance
sudo apt install -y code-oss remmina zathura unclutter imagemagick htop neofetch arandr flameshot

# Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip
sudo unzip UbuntuMono.zip -d /usr/share/fonts/
fc-cache -fv

# Alacritty
wget https://github.com/barnumbirr/alacritty-debian/releases/download/v0.10.1-1/alacritty_0.10.1-1_amd64_bullseye.deb
sudo dpkg -i alacritty_0.10.1-1_amd64_bullseye.deb
sudo apt install -f

# GTK Nordic theme
wget https://github.com/EliverLara/Nordic/archive/refs/tags/v2.1.0.zip
sudo unzip v2.1.0.zip -d /usr/share/themes/
lxappearance && sleep 20

# Papirus Nord 
git clone https://github.com/Adapta-Projects/Papirus-Nord.git
cd Papirus-Nord
chmod u+x install
sudo ./install && sleep 5 
/usr/bin/papirus-folders -C frostblue3
cd ..

mkdir -p ~/.config/i3
mkdir -p ~/.config/compton
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
mkdir -p ~/.local/share/fonts
mkdir -p ~/.wallpaper
cp -r i3/ ~/.config/
cp alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp compton/compton.conf ~/.config/compton/compton.conf
cp -r rofi/ ~/.config/
cp -rf rofifonts/* ~/.local/share/fonts/
find ~/.config/rofi/ -type f -iname "*.sh" -exec chmod +x {} \;
cp fehbg ~/.fehbg
chmod u+x ~/.fehbg
cp wallpaper/wallpaper.jpg ~/.wallpaper/

# change default terminal ( => qterminal to alacritty)
sudo update-alternatives --config x-terminal-emulator 

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
