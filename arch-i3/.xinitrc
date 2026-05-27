#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

export GTK_THEME="Adwaita:dark"

# Start gnome-keyring for the Secret Service API (org.freedesktop.secrets).
# SSH keys stay with openssh's ssh-agent, so the ssh component is excluded.
# The keyring starts locked and prompts (via gcr) on first access.
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)"
export GNOME_KEYRING_CONTROL

#
# Example setting higher refresh rate (specific to output port and monitor):
#
# xrandr --output HDMI-A-0 --mode 2560x1440 --rate 144 &
#

exec i3
