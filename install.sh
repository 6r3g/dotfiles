#!/bin/sh

sudo apt install -y i3-gaps i3-gaps-wm compton rofi papirus-icon-theme flameshot feh 
sudo apt install -y code-oss remmina zathura unclutter imagemagick htop neofetch arandr

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
mv ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml.old
cp xsettings.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/

# Papirus Nord 
git clone https://github.com/Adapta-Projects/Papirus-Nord.git
cd Papirus-Nord

PREFIX="Icons"
LOCAL="/usr/share/icons/Papirus"
sudo cp -f $PREFIX/64x64/* $LOCAL/64x64/places
sudo cp -f $PREFIX/48x48/* $LOCAL/48x48/places
sudo cp -f $PREFIX/32x32/* $LOCAL/32x32/places
sudo cp -f $PREFIX/24x24/* $LOCAL/24x24/places
sudo cp -f $PREFIX/22x22/* $LOCAL/22x22/places
cp -f papirus-folders /usr/bin
/usr/bin/papirus-folders -C frostblue3
cd ..

mkdir -p ~/.config/i3
mkdir -p ~/.config/compton
mkdir -p ~/.config/rofi
mkdir -p ~/.config/alacritty
mkdir -p ~/.wallpaper
cp -r .config/i3/ ~/.config/i3/
cp .config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
cp .config/compton/compton.conf ~/.config/compton/compton.conf
cp -r .config/rofi/ ~/.config/rofi/
cp .fehbg ~/.fehbg
cp -r wallpaper ~/.wallpaper 

# change default terminal ( => qterminal to alacritty)
sudo update-alternatives --config x-terminal-emulator 

# OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
