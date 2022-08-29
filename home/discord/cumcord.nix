{ lib, stdenv, fetchurl, fetchFromGitHub, nodejs }:

let
  injector = fetchurl {
    url = "https://raw.githubusercontent.com/Cumcord/Impregnate/74df5c8613d0b172d41dd6a898fca0d6a0d5c945/middle/injector.go";
    sha256 = "0b71a1ba3ad025407d9c4f6c64d9aae1344b3033d17957f2a07f04a767116120";
  };

in
stdenv.mkDerivation rec {
  pname = "cumcord";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "Cumcord";
    repo = "Cumcord";
    rev = "b67976f592fe98e91c548e97183f07133a1cc88a";
    hash = "sha256-om4L8GTOJbwJArSjF5zeMamSJ0Kz1g70UdE+Jr2gGyw=";
  };

  buildPhase = ''
    runHook preBuild

    cat ${injector} | grep -oP "(?<=\")(.*?)(?=\")" > rd.b64
    cat rd.b64 | base64 -d > rd.js
  '';

  installPhase = ''
    runHook preInstall

    install rd.js $out

    runHook postInstall
  '';

  meta = with lib; {
    description = "Client mod for Discord.";
    homepage = "https://cumcord.com";
    license = licenses.cc0;
    platforms = nodejs.meta.platforms;
  };
}
