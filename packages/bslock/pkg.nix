{ stdenv, pkgs, xorgproto, libX11, libXinerama, libXext, libXrandr }:
with pkgs.lib;

let
  user = "imsohexy";
  group = "users";
in stdenv.mkDerivation rec {
  name = "local-bslock-${version}";
  version = "0.0.1";

  src = ./source;

  buildInputs = [ xorgproto libX11 libXinerama libXext libXrandr ];

  unpackPhase = ''cp -r $src/* .'';

  postPatch = "
    # sed -e 's/@@user/${user}/' -e 's/@@group/${group}/' -i config.def.h;
    sed -i '/chmod u+s/d' Makefile;
  ";

  buildPhase = ''make'';

  installPhase = ''make PREFIX=$out DESTDIR="" install'';
}
