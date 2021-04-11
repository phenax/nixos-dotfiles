{ pkgs ? import <nixpkgs> {}, ... }:

let
  packages = with pkgs; [
    elmPackages.elm
    elmPackages.create-elm-app
    elmPackages.elm-format
    elmPackages.elm-language-server
    nodejs-15_x
    yarn
  ];
in pkgs.stdenv.mkDerivation {
  name = "elm-project";
  buildInputs = packages;
}
