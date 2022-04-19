{ lib, stdenvNoCC, fetchurl, autoPatchelfHook }:

stdenvNoCC.mkDerivation rec {
  pname = "impregnate";
  version = "1.3.1";
  phases = [ "installPhase" "fixupPhase" ];

  src = fetchurl {
    url = "https://github.com/Cumcord/Impregnate/releases/download/v${version}/impregnate.Linux";
    sha256 = "84f0477e1a03762113e8b3649fd19064063f4162746fae3bf1a0eedf3bb5f192";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  sourceRoot = ".";

  installPhase = ''
    install -m755 -D ${src} $out/bin/impregnate
  '';

  meta = with lib; {
    description = "Cumcord installer";
    homepage = "https://github.com/Cumcord/Impregnate";
    platforms = platforms.linux;
  };
}
