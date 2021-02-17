{ stdenv, pkgs, libX11, pkgconfig }:
with pkgs.lib;

stdenv.mkDerivation rec {
  name = "local-dwmblocks-${version}";
  version = "0.1.0";

  src = ./source;

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libX11 ];


  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
