{ config, pkgs, ... } :

{
    # TODO: implement overriders for Hyprland configuration

    home.file = {
        ".bashrc".source = ./dotfiles/bashrc/.bashrc;
        ".gitconfig".source = ./dotfiles/git/.gitconfig;
        ".vimrc".source = ./dotfiles/vimrc/.vimrc;
    };

    xdg = {
        enable = true;

        configFile = {
            "fastfetch" = {
                source = ./dotfiles/fastfetch/.config/fastfetch;
                recursive = true;
            };
            "hypr" = {
                source = ./dotfiles/hypr/.config/hypr;
                recursive = true;
            };
            "kitty" = {
                source = ./dotfiles/kitty/.config/kitty;
                recursive = true;
            };
            "neofetch" = {
                source = ./dotfiles/neofetch/.config/neofetch;
                recursive = true;
            };
            "nushell" = {
                source = ./dotfiles/nushell/.config/nushell;
                recursive = true;
            };
            "nvim" = {
                source = ./dotfiles/nvim/.config/nvim;
                recursive = true;
            };
            "waybar" = {
                source = ./dotfiles/waybar/.config/waybar;
                recursive = true;
            };
        };

        dataFile = {
            "cursors/miku-cursor-linux" = {
                source = ./themes/cursors/miku-cursor-linux/.local/share;
                recursive = true;
            };
            "wallpapers/hyprlock-bg" = {
                source = ./themes/wallpapers/hyprlock-bg/.local/share/wallpapers/hyprlock-bg;
                recursive = true;
            };
            "wallpapers/hyprpaper-bg" = {
                source = ./themes/wallpapers/hyprpaper-bg/.local/share/wallpapers/hyprpaper-bg;
                recursive = true;
            };
        };
    };
}
