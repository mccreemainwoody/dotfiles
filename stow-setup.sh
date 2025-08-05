cd ./dotfiles
stow --target ~ neofetch
stow --target ~ fastfetch
stow --target ~ bashrc
stow --target ~ vimrc
stow --target ~ git
stow --target ~ kitty
stow --target ~ nvim
stow --target ~ waybar
stow --target ~ hypr

cd ../themes

cd cursors
stow --target ~ miku-cursor-linux

cd ../wallpapers
stow --target ~ hyprlock-bg

cd ../../

echo "Setup succeeded ! Don't forget to add a startup sound if you want to " \
     "at ~/.local/share/audio/startup.sh"
