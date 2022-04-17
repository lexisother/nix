{ config, pkgs, specialArgs, ... }:

let
  textEditor = "nvim";

  packageSets = with pkgs; rec {
    base = [
      sqlite
      jq
      ripgrep
      curl
      htop
      tree
      wget
      nixfmt
    ];

    languages = [
      nodejs
    ];

    tooling =
      [ nodePackages.prettier shellcheck stylua ];

    multimedia = [ ffmpeg ];

    everything = base ++ languages ++ tooling ++ multimedia;
  };

in
{
  imports = [ ./git.nix ];

  programs.home-manager.enable = true;

  home = {
    username = "alyxia";
    homeDirectory = "/home/alyxia";
    packages = packageSets.everything;

    sessionVariables = {
      EDITOR = textEditor;
    };
  };

  home.stateVersion = "22.05";
}
