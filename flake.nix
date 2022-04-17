{
  description = "alyxia's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    (let
      baseHomeConfig = {
        configuration.imports = [ ./home/home.nix ];
      };

      hm = { system, username ? "alyxia", homeDirectory ? "/home/alyxia"
        , server ? false }:
        home-manager.lib.homeManagerConfiguration (baseHomeConfig // {
          inherit username system homeDirectory;
          extraSpecialArgs = { inherit server; };
          stateVersion = "22.05";
        });
    in {
      packages = {
        x86_64-linux.homeConfigurations.alyxia = hm {
          system = "x86_64-linux";
          server = true;
        };
      };
    });
}
