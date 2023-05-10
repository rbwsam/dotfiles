#!/bin/bash

# Exit on error
set -e

# Create directories
mkdir -p ~/bin ~/tmp ~/go ~/Downloads

# Install packages
sudo pacman -Sy --needed i3 dmenu xss-lock i3lock dex xorg-xset xorg-xrdb xorg-xrandr htop xsel iotop sysstat vim curl git git-delta bat jq go python python-pip ttf-inconsolata transmission-gtk vlc chromium gimp fwupd acpi bash-completion alacritty ruby brightnessctl pulsemixer man

# Configure bash
echo -e "\nsource ~/code/rbwsam/dotfiles/.bashrc" >> ~/.bashrc

# Configure git
ln -s ~/code/rbwsam/dotfiles/.gitignoreglobal ~/.gitignoreglobal
cp ~/code/rbwsam/dotfiles/.gitconfig ~/

# Configure desktop
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

ln -s ~/code/rbwsam/dotfiles/.xinitrc ~/.xinitrc
ln -s ~/code/rbwsam/dotfiles/.config/i3 ~/.config/i3
ln -s ~/code/rbwsam/dotfiles/.config/i3status ~/.config/i3status
ln -s ~/code/rbwsam/dotfiles/.config/alacritty ~/.config/alacritty
ln -s ~/code/rbwsam/dotfiles/.config/picom ~/.config/picom
ln -s ~/code/rbwsam/dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0

# Configure X11
sudo cp xorg.conf.d/* /etc/X11/xorg.conf.d/

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

# Install AUR packages
yay -Sy --needed mullvad-vpn-bin zoom sublime-text

# Install pipenv
pip install --user pipenv
