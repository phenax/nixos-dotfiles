{ stdenv, pkgs, dmenu ? (import ../default.nix { pkgs = pkgs; }).dmenu }:
with stdenv.lib;

stdenv.mkDerivation rec {
  name = "local-anypinentry-${version}";
  version = "0.0.0";

  src = ./source;

  wrapperPath = makeBinPath ([ dmenu ]);

  unpackPhase = ''cp -r $src/* .'';
  installPhase = ''
    mkdir -p $out/bin;
    cp $src/anypinentry $out/bin/
  '';
}
