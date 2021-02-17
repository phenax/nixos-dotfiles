{ stdenv, pkgs, libX11, libXinerama, libXft }:
with pkgs.lib;

stdenv.mkDerivation rec {
  name = "local-dwm-${version}";
  version = "6.2.0";

  src = ./source;

  buildInputs = [ libX11 libXinerama libXft ];


  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
