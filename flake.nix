{
  description = "alyxia's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    (
      let
        baseHomeConfig = {
          configuration.imports = [ ./home/home.nix ];
          extraModules = [ ./modules/impregnate ];
        };

        hm =
          { system
          , username ? "alyxia"
          , homeDirectory ? "/home/alyxia"
          , server ? false
          }:
          home-manager.lib.homeManagerConfiguration (baseHomeConfig // {
            inherit username system homeDirectory;
            extraSpecialArgs = {
              inherit server;
              inherit (inputs) dotfiles;
            };
            stateVersion = "22.05";
          });
      in
      {
        packages = {
          x86_64-linux.homeConfigurations.alyxia = hm {
            system = "x86_64-linux";
            server = true;
          };
        };
      }
    );
}
