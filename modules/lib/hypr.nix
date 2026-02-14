{ config, lib, ... }:

let
    cfg = config.home.my-dotfiles;
in
{
    options = {
        home.my-dotfiles = {
            overrides = {
                hyprland = {
                    extras = lib.mkOption {
                        type = lib.types.str;
                        default = ''
                        '';
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
                        default = ''
                        '';
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

    config = lib.mkIf cfg.enable
        {
            home.activation = {
                applyOverrides = lib.hm.dag.entryAfter
                    [ "cloneDotfiles" ]
                    ''
                    #!/bin/sh

                    hyprland_overrides_path="${config.xdg.configHome}/hypr/hyprland/overrides.conf"
                    hyprland_overrides_env_path="${config.xdg.configHome}/hypr/hyprland/overrides-env.conf"

                    hyprland_overrides_content="${cfg.overrides.hyprland.extras}"
                    hyprland_overrides_env_content="${cfg.overrides.hyprland.extras-env}"


                    dry_run() {
                        echo "would write $hyprland_overrides_env_content to $hyprland_overrides_env_path"
                        echo "would write $hyprland_overrides_content to $hyprland_overrides_path"
                    }

                    write_overrides() {
                        echo \
                            "$hyprland_overrides_env_content" \
                            > "$hyprland_overrides_env_path"
                        echo \
                            "$hyprland_overrides_content" \
                            > "$hyprland_overrides_path"
                    }

                    # if [ -n "$DRY_RUN" ]; then
                    #     dry_run
                    # else
                    write_overrides
                    # fi
                    '';
            };

            xdg = {
                enable = true;
                configFile = {
                    "hypr".source = config.lib.file.mkOutOfStoreSymlink
                        "${config.home.homeDirectory}/dotfiles/dotfiles/hypr/.config/hypr";
                };
            };
        };
}
