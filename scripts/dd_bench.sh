#!/bin/bash

COUNT=2048
PREFIX="> "

if [ "$EUID" -ne 0 ]
  then echo "Must be run as root (or with sudo)"
  exit
fi

echo "$PREFIX Writing..."
dd if=/dev/zero of=tempfile bs=1M count=$COUNT conv=fdatasync,notrunc

echo "$PREFIX Dropping caches..."
echo 3 > /proc/sys/vm/drop_caches

echo "$PREFIX Reading..."
dd if=tempfile of=/dev/null bs=1M count=$COUNT

echo -n "$PREFIX Cleaning up... "
rm tempfile
echo "all done!"