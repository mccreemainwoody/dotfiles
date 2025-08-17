#!/bin/sh

set -e

cd ./dotfiles
stow --target ~ \
    bashrc \
    fastfetch \
    git \
    hypr \
    kitty \
    neofetch \
    nushell \
    nvim \
    vimrc \
    waybar

cd ../themes

cd cursors
stow --target ~ miku-cursor-linux

cd ../wallpapers
stow --target ~ hyprlock-bg

cd ../../

echo "Setup succeeded ! Don't forget to add a startup sound if you want to " \
     "at ~/.local/share/audio/startup.sh"
