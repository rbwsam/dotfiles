#!/bin/bash

set -euo pipefail

# Get the script dir
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

export DEBIAN_FRONTEND=noninteractive

# Create directories
mkdir -p ~/bin ~/tmp

# Install packages
sudo apt-get update -qq
sudo apt-get install -y --no-install-recommends curl vim git git-delta htop btop jq rsync pigz ncdu lsd bat tree tmux ripgrep glow

# Enable ssh agent
systemctl --user enable --now ssh-agent.socket

# Configure bash
cp "$SCRIPT_DIR"/.sam.sh ~/
grep -qxF 'source ~/.sam.sh' ~/.bashrc || echo -e '\nsource ~/.sam.sh' >> ~/.bashrc

# Configure git
cp "$SCRIPT_DIR"/.gitignoreglobal ~/
cp "$SCRIPT_DIR"/.gitconfig ~/

# Configure tmux
cp "$SCRIPT_DIR"/.tmux.conf ~/

# Configure claude
mkdir -p ~/.claude
ln -sf "$SCRIPT_DIR"/CLAUDE.md ~/.claude/CLAUDE.md

# Configure ssh
install -m 600 "$SCRIPT_DIR"/.ssh/config ~/.ssh/config

# Configure everything else
cp -r "$SCRIPT_DIR"/.config ~/
