#!/bin/bash

# Derived from https://help.ubuntu.com/community/SwapFaq

if [ "$EUID" -ne 0 ]
  then echo "Must be run as root (or with sudo)"
  exit
fi

target=10
current=$(cat /proc/sys/vm/swappiness)

if (( current <= target )); then
    echo "swappiness is already set to $current, you're all good bro"
    exit
fi

echo "swappiness is high at $current, setting to $target right now"
sysctl -q vm.swappiness=$target

echo "saving the setting for future boots"
printf "vm.swappiness=$target\n" > /etc/sysctl.d/99-swappiness.conf

echo "you're all set"