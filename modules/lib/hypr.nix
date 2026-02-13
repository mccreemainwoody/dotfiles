{ config, lib, ... }:

let
    cfg = config.home.my-dotfiles;

    defaultFiles =
        lib.filesystem.listFilesRecursives ../dotfiles/hypr/.config/hypr;

    defaultConfig =
        builtins.listToAttrs
        map (name: { source = ../dotfiles/hypr/.config/hypr/${name} })
        defaultFiles;

    defaultOverrideStates = {
        script = builtins.readFile
            ./dotfiles/hypr/.config/hypr/hyprland/overrides.conf;

        env-vars = builtins.readFile
            ./dotfiles/hypr/.config/hypr/hyprland/overrides-env.conf;
    };
in
{
    options = {
        home.my-dotfiles = {
            overrides = {
                hyprland = {
                    extras = lib.mkOption {
                        type = lib.types.str;
                        default = defaultOverrideStates.script;
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
                        default = defaultOverrideStates.env-vars;
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

    config = lib.mkIf cfg.enable let
        overrides = {
            "hypr/hyprland/overrides.hypr".text = cfg.overrides.hyprland.extras;
            "hypr/hyprland/overrides-env.hypr".text =
                cfg.overrides.hyprland.extras-env;
        };
    in
    {
        xdg = {
            enable = true;
            configFile = defaultFiles // overrides;
        };
    };
}
