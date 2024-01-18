#!/bin/bash

# Exit on error
set -e

# Create directories
mkdir -p ~/.ssh ~/bin ~/tmp ~/go ~/Downloads

# Install packages
sudo pacman -Sy --needed htop iotop sysstat vim curl git git-delta bat jq go acpi bash-completion man unzip openssh

# Configure bash
echo -e "\nsource ~/code/rbwsam/dotfiles/.bashrc" >> ~/.bashrc

# Configure git
ln -s ~/code/rbwsam/dotfiles/.gitignoreglobal ~/.gitignoreglobal
cp ~/code/rbwsam/dotfiles/.gitconfig ~/
ln -s ~/code/rbwsam/dotfiles/.ssh/config ~/.ssh/config

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

