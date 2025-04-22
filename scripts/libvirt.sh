#!/bin/bash

yay -S --needed libvirt dnsmasq dmidecode qemu-desktop openbsd-netcat swtpm x11-ssh-askpass qemu-tools iptables-nft virt-manager
sudo gpasswd -a $USER libvirt
