#!/bin/bash

# Exit on error
set -e

# Get the script dir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Create directories
mkdir -p ~/bin ~/tmp ~/Downloads

# Install packages
sudo pacman -Sy --needed htop iotop sysstat vim curl git git-delta bat jq go fwupd udisks2 acpi bash-completion man unzip openssh pigz rsync uv lsd calc httpie ripgrep dosfstools exfatprogs bind ncdu csvlens base-devel direnv tree tmux

# Enable ssh agent
systemctl --user enable --now ssh-agent

# Configure bash
cp $SCRIPT_DIR/.sam.sh ~/
echo -e "\nsource ~/.sam.sh" >> ~/.bashrc

# Configure git
cp $SCRIPT_DIR/.gitignoreglobal ~/
cp $SCRIPT_DIR/.gitconfig ~/

# Configure everything else
cp -r $SCRIPT_DIR/.ssh ~/
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

