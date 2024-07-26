#!/bin/bash

# Exit on error
set -e

# Get the script dir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Configure X11
sudo cp $SCRIPT_DIR/xorg.conf.d/* /etc/X11/xorg.conf.d/

# Create directories
mkdir -p ~/bin ~/tmp ~/Downloads

# Install packages
sudo pacman -Sy --needed i3 dmenu xss-lock i3lock dex xorg-xset xorg-xrdb xorg-xrandr htop xsel iotop sysstat vim curl git git-delta bat jq go ttf-inconsolata transmission-gtk vlc chromium gimp fwupd udisks2 acpi bash-completion alacritty brightnessctl pulsemixer man gnome-screenshot fuse2 libappindicator-gtk3 noto-fonts noto-fonts-emoji noto-fonts-cjk unzip openssh x11-ssh-askpass pigz rsync direnv python-pipx lsd ttf-firacode-nerd calc android-file-transfer httpie

# Dark mode in gsettings
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Enable ssh agent
systemctl --user enable --now ssh-agent

# Configure bash
cp $SCRIPT_DIR/.bashrc_sam ~/
echo -e "\nsource ~/.bashrc_sam" >> ~/.bashrc

# Configure git
cp $SCRIPT_DIR/.gitignoreglobal ~/
cp $SCRIPT_DIR/.gitconfig ~/

# Configure everything else
cp -r $SCRIPT_DIR/.ssh ~/
cp -r $SCRIPT_DIR/.xinitrc ~/
cp -r $SCRIPT_DIR/.Xresources ~/
cp -r $SCRIPT_DIR/.config ~/

# Install yay
mkdir ~/tmp/yay
pushd ~/tmp/yay
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
tar -xf yay.tar.gz
cd yay
makepkg -si --needed
popd
yay --version
rm -rf ~/tmp/yay

