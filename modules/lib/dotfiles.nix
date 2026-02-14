{ config, lib, pkgs, ... }:

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
        home = {
            activation = {
                cloneDotfiles = lib.hm.dag.entryAfter
                    [ "installPackages" "git" ]
                    ''
                    #!/bin/sh

                    OLD_PATH="$PATH"
                    PATH="${lib.makeBinPath [ pkgs.git ]}:$PATH"

                    dotfiles_installation_path="${config.home.homeDirectory}/dotfiles"

                    if [ -d "$dotfiles_installation_path" ]; then
                        cd "$dotfiles_installation_path"
                        run --quiet git stash
                        run --quiet git pull
                        run --quiet git stash pop || true
                        cd -
                    else
                        run \
                            git clone \
                            https://github.com/mccreemainwoody/dotfiles.git \
                            "$dotfiles_installation_path"
                    fi

                    PATH="$OLD_PATH"
                    '';
            };

            file = {
                ".bashrc".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/bashrc/.bashrc";

                ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/git/.gitconfig";

                ".vimrc".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/vimrc/.vimrc";
            };
        };

        programs.git.enable = true;

        xdg = {
            enable = true;

            configFile = {
                "fastfetch".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/fastfetch/.config/fastfetch";

                "kitty".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/kitty/.config/kitty";

                "neofetch".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/neofetch/.config/neofetch";

                "nushell" = {
                    # FIXME: fix the "error installing file outside $HOME"
                    source = ../../dotfiles/nushell/.config/nushell;
                    recursive = true;
                };

                "nvim".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/nvim/.config/nvim";

                "waybar".source = config.lib.file.mkOutOfStoreSymlink
                    "${config.home.homeDirectory}/dotfiles/dotfiles/waybar/.config/waybar";
            };

            dataFile = {
                "cursors/miku-cursor-linux" = {
                    source = "${config.home.homeDirectory}/dotfiles/themes/cursors/miku-cursor-linux/.local/share";
                    recursive = true;
                };

                "wallpapers/hyprlock-bg" = {
                    source = "${config.home.homeDirectory}/dotfiles/themes/wallpapers/hyprlock-bg/.local/share/wallpapers/hyprlock-bg";
                    recursive = true;
                };

                "wallpapers/hyprpaper-bg" = {
                    source = "${config.home.homeDirectory}/dotfiles/themes/wallpapers/hyprpaper-bg/.local/share/wallpapers/hyprpaper-bg";
                    recursive = true;
                };
            };
        };
    };
}
