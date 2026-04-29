#!/bin/bash
set -e

xrandr --output DP-0 --primary --mode 2560x1440 --rate 100 \
       --output DP-2 --mode 2560x1440 --rate 100 --right-of DP-0

