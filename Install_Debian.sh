#!/bin/bash

user=$(whoami)

# Install base packages
sudo apt-get update && sudo apt-get install -y \
    software-properties-common \

# More repos
sudo apt-add-repository -y contrib non-free non-free-firmware

sudo apt-get update && sudo apt-get install -y \
    apt-transport-https \
    arandr \
    bat \
    bind9-dnsutils \
    binutils \
    btop \
    cups \
    curl \
    duf \
    fd-find \
    feh \
    firefox-esr \
    flameshot \
    fonts-noto-color-emoji \
    git \
    gpg \
    i3 \
    imagemagick \
    jq \
    libimage-exiftool-perl \
    lightdm-gtk-greeter-settings \
    lightdm lightdm-gtk-greeter \
    lxappearance \
    miller \
    mousepad \
    neofetch \
    net-tools \
    network-manager-gnome \
    nmap \
    peek \
    pipx \
    pulseaudio pulseaudio-utils \
    qdirstat \
    qt5ct \
    remmina \
    remmina-plugin-rdp \
    remmina-plugin-vnc \
    ristretto \
    rofi \
    scrot \
    silversearcher-ag \
    ssh \
    sshfs \
    sshpass \
    sslscan \
    thunar \
    tmux \
    transmission \
    tree \
    unclutter \
    unrar-free \
    vagrant \
    vim \
    vim-gtk3 \
    vlc \
    wamerican \
    wfrench \
    whois \
    wireshark tshark\
    xarchiver \
    xclip \
    xfce4-power-manager \
    xfce4-terminal \
    xsel \
    xxd \
    xz-utils \
    zathura \
    zip \
    unzip \

# Nerd Fonts
mkdir -p ~/.local/share/fonts/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
wget https://www.omnibus-type.com/wp-content/uploads/Saira-Semi-Condensed.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
unzip Saira-Semi-Condensed.zip -d ~/.local/share/fonts/
fc-cache -fv

# Config files
mkdir -p ~/.config/bat/themes
mkdir -p ~/.config/btop/themes
mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/dunst
mkdir -p ~/.config/fzf/
mkdir -p ~/.config/picom
mkdir -p ~/.config/qt5ct
mkdir -p ~/.config/rofi
mkdir -p ~/.config/scripts
mkdir -p ~/.config/vim/{autoload,colors}
mkdir -p ~/.config/xfce4/terminal
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml
mkdir -p ~/.local/share/xfce4/terminal/colorschemes

cp config/bash/bash_aliases ~/.bash_aliases
cp config/bash/bash_functions ~/.bash_functions
cp config/bash/bashrc ~/.bashrc
cp config/bat/config ~/.config/bat/
cp config/bat/config/themes/* ~/.config/bat/themes/
cp config/btop/themes/* ~/.config/btop/themes/
cp config/dunst/dunstrc ~/.config/dunst/dunstrc
cp config/fzf/*.bash ~/.config/fzf/
cp config/i3/config ~/.config/i3/config
cp config/i3status/config ~/.config/i3status/config
cp config/nano/nanorc ~/.nanorc
cp config/picom/picom.conf ~/.config/picom/picom.conf
cp config/qt5ct/qt5ct.conf ~/.config/qt5ct/qt5ct.conf
cp config/rofi/*.rasi ~/.config/rofi/
cp config/scripts/* ~/.config/scripts/
chmod u+x ~/.config/scripts/*.sh
cp local/share/xfce4/terminal/colorschemes/* ~/.local/share/xfce4/terminal/colorschemes/
cp config/tmux/tmux.conf ~/.tmux.conf
cp config/vim/vimrc ~/.config/vim/vimrc
cp config/vim/colors/*.vim ~/.config/vim/colors/
ln -s ~/.config/vim ~/.vim
ln -s ~/.config/vim/vimrc ~/.vimrc
cp config/xfce4/terminal/* ~/.config/xfce4/terminal/
cp config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/

# install recent FZF
cd ~/.local/bin/
wget https://github.com/junegunn/fzf/releases/download/v0.56.0/fzf-0.56.0-linux_amd64.tar.gz
tar -xvzf fzf-0.56.0-linux_amd64.tar.gz
chmod u+x fzf
rm fzf-0.56.0-linux_amd64.tar.gz
cd $OLDPWD

# Install VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
#sudo apt-add-repository "deb https://packages.microsoft.com/repos/vscode stable main"
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install -y code

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

# install Virtualbox
platform=$(systemd-detect-virt)
if [ $platform == "none" ]; then 
  echo "[>] Not a in a VM : install vbox"
  sudo apt-get install -y fasttrack-archive-keyring
  sudo apt-add-repository -y "deb http://fasttrack.debian.net/debian-fasttrack/ $(. /etc/os-release && echo "$VERSION_CODENAME")-fasttrack main contrib"
  sudo apt-add-repository -y "deb http://fasttrack.debian.net/debian-fasttrack/ $(. /etc/os-release && echo "$VERSION_CODENAME")-backports-staging main contrib"
  sudo apt-get update
  sudo apt-get install -y virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
else 
  echo "[>] In a VM : install vbox guests tools"
  # todo
fi 

# Install Tailscale
curl -fsSL https://pkgs.tailscale.com/stable/debian/$(. /etc/os-release && echo "$VERSION_CODENAME").noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/debian/$(. /etc/os-release && echo "$VERSION_CODENAME").tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update
sudo apt-get install -y tailscale

# Groups
sudo usermod -aG docker $user
sudo usermod -aG wireshark $user

# Cron
(crontab -l 2>/dev/null; echo "@reboot $HOME/.config/scripts/i3status_ippub.sh") | crontab -