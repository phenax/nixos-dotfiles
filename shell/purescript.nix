{ pkgs ? import <nixpkgs> {}, ... }:

let
  packages = with pkgs; [
    purescript
    spago
    nodePackages.purescript-language-server
    dhall-lsp-server
    nodejs-15_x
    yarn
  ];
in
pkgs.stdenv.mkDerivation {
  name = "purescript-proj";
  buildInputs = packages;
}
