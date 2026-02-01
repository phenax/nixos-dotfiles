{ pkgs ? import <nixpkgs> {} }:
with pkgs.lib;
let
  python = (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
    colorama
    termcolor
    datetime
  ]));
in pkgs.stdenv.mkDerivation {
  pname = "remind-agenda";
  version = "0.0.0";

  src = pkgs.fetchgit {
    url = "https://gitlab.com/dkabus/remind-agenda.git";
    rev = "cf4cd6f79aabb16317fc6008588536af5d2e4d9a";
    hash = "sha256-f8Tmgz9Tw6gQjqtWhvteajOYieAu8OZy/+FHWC9885U=";
  };

  buildInputs = with pkgs; [  ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    cp $src/remind-agenda .
    sed -i 's|/bin/python3|${python}/bin/python3|' ./remind-agenda
  '';

  installPhase = ''
    mkdir -p $out/bin;
    cp ./remind-agenda $out/bin;
  '';
}

