{ pkgs ? import <nixpkgs> {}, ... }:

let
  bsb = pkgs.stdenv.mkDerivation {
    name = "rescript-compiler";
    version = "0.0.0";
    src = pkgs.fetchFromGitHub {
      user = "rescript-lang";
      repo = "rescript-compiler";
    };
  };

  packages = with pkgs; [
    bsb
    nodejs-15_x
    yarn
  ];
in
pkgs.stdenv.mkDerivation {
  name = "elm-project";
  buildInputs = packages;
}
