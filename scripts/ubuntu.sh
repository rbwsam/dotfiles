#!/bin/bash

set -e

sudo apt remove --purge gnome-shell-extension-ubuntu-dock gnome-shell-extension-desktop-icons gnome-shell-extension-desktop-icons-ng

dconf write /org/gnome/shell/window-switcher/current-workspace-only false
dconf write /org/gnome/mutter/dynamic-workspaces false
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-1 "['<Alt>1']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-2 "['<Alt>2']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-3 "['<Alt>3']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-4 "['<Alt>4']"
dconf write /org/gnome/desktop/wm/preferences/button-layout "':close'"
dconf write /org/gnome/shell/enable-hot-corners true
dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"

echo -e "\n\nYou should reboot now.\n"
