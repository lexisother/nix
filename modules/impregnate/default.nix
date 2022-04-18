{ pkgs, lib, stdenv, ... }:

let
  inherit (pkgs) callPackage fetchurl;
  version = "v1.3.1";
  src = {
    url = "https://github.com/Cumcord/Impregnate/releases/download/v1.3.1/impregnate.Linux";
  };
  meta = with lib; {
    description = "Cumcord installer";
    homepage = "https://github.com/Cumcord/Impregnate";
    platforms = platforms.unix;
  };
  package = ./install.nix;
  packages = (builtins.mapAttrs
    (_: value: callPackage package (value // { inherit src version; meta = meta // { mainProgram = value.binaryName; }; }))
    {
      impregnate = rec {
        pname = "impregnate";
        binaryName = "impregnate";
        desktopName = "Impregnate";
      };
    }
  );
in
packages.impregnate
