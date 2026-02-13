{ config, libs, ... }:

let
    cfg = config.home.my-dotfiles;
in
{
    imports = [ ./hypr.nix ];

    options = {
        home.my-dotfiles = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                example = true;
                description = "Enable dotfiles loading into home.";
            };
        };
    };

    config = lib.mkIf cfg.enable {
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
    };
}
