{ config, lib, home-manager, ... }:

{
    options = {
        home.dotfiles = {
            enable = lib.mkOption {
                type = lib.types.bool;
                default = false;
                example = true;
                description = "Enable dotfiles loading into home.";
            };

            overrides = {
                hyprland = {
                    extras = lib.mkOption {
                        type = lib.types.str;
                        default = "";
                        example = ''
                            start-once = fcitx5 &
                        '';
                        description = ''
                            Extra Hyprland instruction to run during Hyprland
                            session.

                            Those instructions will be run after all default
                            instructions, leading to possible overrides.
                        '';
                    };

                    extras-env = lib.mkOption {
                        type = lib.types.str;
                        default = "";
                        example = ''
                            $terminal = alacritty

                            env = XCURSOR_SIZE,12
                        '';
                        description = ''
                            Extra Hyprland instructions to run during Hyprland
                            session.

                            Those instructions will be after configuration of
                            default variables and before running all the other
                            instructions of the environment setup.

                            Use this to add/override environment variables and
                            change your default terminal, GTK theme...
                        '';
                    };
                };
            };
        };
    };

    config = {
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

                "hypr/hyprland/overrides-env.conf".text =
                    home-manager.dag.entryAfter
                    [ "hypr" ]
                    config.home.dotfiles.overrides.hyprland.extras-env;

                "hypr/hyprland/overrides.conf".text =
                    home-manager.dag.entryAfter
                    [ "hypr" ]
                    config.home.dotfiles.overrides.hyprland.extras;
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
