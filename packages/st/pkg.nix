{ stdenv, pkgs, libX11, libXinerama, libXft, fontconfig, pkgconfig, ncurses }:
with pkgs.lib;

stdenv.mkDerivation rec {
  name = "local-st-${version}";
  version = "0.8.4";

  src = ./source;

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ libX11 libXft fontconfig ncurses ];


  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''TERMINFO=$out/share/terminfo make PREFIX=$out DESTDIR="" install'';
}
