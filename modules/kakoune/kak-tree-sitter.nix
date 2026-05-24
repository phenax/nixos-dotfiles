{ lib, pkgs }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "kak-tree-sitter";
  version = "3.0.0-local.2";

  src = fetchFromSourcehut {
    owner = "~hadronized";
    repo = "kak-tree-sitter";
    rev = "e4e1d270129c985cbf2a39e23ef1e41323bfc84e"; # 24 May 2026
    hash = "sha256-+bu5Z6bntJYQ3x/NdBiMeZ4mnhLqFoF1jcUh422FMPQ=";
  };

  cargoHash = "sha256-ztVBBeLU1AByDz3yVDMZ102bDG6JfL/6IoJlcqRmCmU=";

  meta = {
    mainProgram = "kak-tree-sitter";
  };
}
