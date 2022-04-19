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
        system = args.system or "x86_64-linux";
        configuration.imports = [ ./home/home.nix ];
        homeDirectory = "/home/alyxia";
        username = "alyxia";
        pkgs = pkgsForSystem system;
        stateVersion = "22.05";
      } // args);

    in
    utils.lib.eachSystem [ "x86_64-linux" ]
      (system: rec {
        legacyPackages = pkgsForSystem system;
      }) // {
      overlay = localOverlay;

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
