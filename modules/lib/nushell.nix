{
  config,
  lib,
  ...
}: let
  inherit (config.home.my-dotfiles) dotfilesLocalPath;
  cfg_root = config.home.my-dotfiles;
  cfg = config.home.my-dotfiles.packages.nushell;
in {
  options = {
    home.my-dotfiles.packages.nushell = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        example = true;
        description = "Enable dotfiles for nushell";
      };
    };
  };

  config = lib.mkIf (cfg_root.enable && cfg.enable) {
    xdg = {
      enable = true;

      configFile."nushell" = {
        # FIXME: fix the "error installing file outside $HOME"
        source = ../../dotfiles/nushell/.config/nushell;
        recursive = true;
      };
    };
  };
}
