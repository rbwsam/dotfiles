#!/bin/bash
set -e

yay -S --needed docker docker-compose docker-buildx
sudo gpasswd -a $USER docker
