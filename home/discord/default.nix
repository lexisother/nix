{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.discord;
in
{
  options.discord = {
    enable = mkEnableOption "discord";
    withCumcord = mkEnableOption "withCumcord";
  };

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.discord.overrideAttrs (old: rec {
        enable = true;
        cumcord = pkgs.callPackage ./cumcord.nix { };
        postInstall = optionalString cfg.withCumcord ''
          mkdir $out/opt/Discord/resources/app
          echo '{"name":"plug","main":"index.js"}' > $out/opt/Discord/resources/app/package.json
          cp -f ${cumcord} $out/opt/Discord/resources/app/index.js
        '';
      }))
    ];
  };
}
