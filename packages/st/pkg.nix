{ stdenv, pkgs, libX11, libXft, fontconfig, pkg-config, ncurses, imlib2 }:

stdenv.mkDerivation rec {
  name = "local-st-${version}";
  version = "0.9.4";

  src = ./source;

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libX11 libXft fontconfig ncurses imlib2 ];

  unpackPhase = ''cp -r $src/* .'';

  buildPhase = ''make'';

  installPhase = ''TERMINFO=$out/share/terminfo make PREFIX=$out DESTDIR="" install'';
}
