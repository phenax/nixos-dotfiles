{}:
with import <nixpkgs> {};
let
  idrDependencies = with pkgs.idrisPackages; [
    js
  ];
  dependencies = with pkgs; [
    idris2
  ];
in
stdenv.mkDerivation {
  name = "idris-pigeon";
  buildInputs = dependencies ++ idrDependencies;
}
