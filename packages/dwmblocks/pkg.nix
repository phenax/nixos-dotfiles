{ stdenv, pkgs, libX11, pkg-config }:
with pkgs.lib;

stdenv.mkDerivation rec {
  name = "local-dwmblocks-${version}";
  version = "0.1.0";

  src = ./source;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libX11 ];


  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
