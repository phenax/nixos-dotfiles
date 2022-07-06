{ stdenv, pkgs, libX11, ... }:
with pkgs.lib;

stdenv.mkDerivation rec {
  name = "local-shotkey-${version}";
  version = "0.1.0";

  src = ./source;

  buildInputs = [ libX11 ];


  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
