{
  description = "alyxia's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url = "https://github.com/keanuplayz/dotfiles";
      type = "git";
      submodules = true;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, utils, ... }:
    let
      # I sure hope I'll only be running this on one arch...
      system = "x86_64-linux";

      localOverlay = prev: final: {
        impregnate = final.callPackage ./pkgs/impregnate.nix { };
      };

      pkgsForSystem = system: import nixpkgs {
        overlays = [
          localOverlay
        ];
        inherit system;
      };

      # TODO: Make a bit more like the old one
      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
        pkgs = pkgsForSystem system;
        modules = [
          ./home/home.nix
        ];
      } // args);

    in
    utils.lib.eachSystem [ "x86_64-linux" ]
      (system: rec {
        legacyPackages = pkgsForSystem system;
      }) // {
      overlays.default = localOverlay;

      homeConfigurations.alyxia = mkHomeConfiguration {
        extraSpecialArgs = {
          withGUI = true;
          isDesktop = true;
          inherit localOverlay;
          inherit dotfiles;
        };
      };
    };
}
