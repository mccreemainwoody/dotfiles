{
    description = "Nix Home-Manager configuration for dotfiles";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... } @_ : {
        homeConfigurations.default = ./modules/lib;
    };
}
