# { stdenv, libX11, libXft, fontconfig, freetype, pkg-config, ncurses, imlib2 }:
#
# stdenv.mkDerivation {
#   pname = "local-st";
#   version = "0.9.4";
#
#   src = ./source;
#
#   strictDeps = true;
#   nativeBuildInputs = [ pkg-config fontconfig freetype ncurses ];
#   buildInputs = [ libX11 libXft fontconfig imlib2 ];
#
#   outputs = [ "out" ];
#
#   unpackPhase = ''cp -r $src/* .'';
#
#   makeFlags = [
#     "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
#   ];
#   buildPhase = ''make'';
#
#   installFlags = [ "PREFIX=$(out)" "DESTDIR=''" ];
#   installPhase = ''TERMINFO=$out/share/terminfo make install'';
# }

{...}:
(builtins.getFlake "path:/home/imsohexy/nixos/packages/st/source").packages.x86_64-linux.default

