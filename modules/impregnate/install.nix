{ pname, version, src, meta, binaryName, desktopName, lib, stdenv, makeDesktopItem }:

stdenv.mkDerivation rec {
  inherit pname version src meta;

  desktopItem = makeDesktopItem {
    name = pname;
    exec = binaryName;
    icon = pname;
    inherit desktopName;
    genericName = meta.description;
    categories = [ "Network" "InstantMessaging" ];
  };
}
