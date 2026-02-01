{ lib, pkgs }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "kak-tree-sitter";
  version = "3.0.0-local.1";

  src = fetchFromSourcehut {
    owner = "~hadronized";
    repo = "kak-tree-sitter";
    rev = "e183201ebdd247b7bbefb9ce9cab10930788aa05"; # 3 Jan 2026
    hash = "sha256-iDpWzvtM0xQSEqs+TsfW3AGaMYwYkHwWqKrbWPRposc=";
  };

  cargoHash = "sha256-WblDG+8GSsy3s2dDE7fgWY6Jkoe7Qqw0ijPR/YQrX7I=";

  meta = {
    mainProgram = "kak-tree-sitter";
  };
}
