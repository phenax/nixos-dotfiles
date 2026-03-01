{ lib, pkgs }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "kak-tree-sitter";
  version = "3.0.0-local.2";

  src = fetchFromSourcehut {
    owner = "~hadronized";
    repo = "kak-tree-sitter";
    rev = "5fe17202e3b818da0f12790d8186fd5ea5e22f6b"; # 28 Feb 2026
    hash = "sha256-z89g58Dr+c1TW9qQVpry1HRNcbxOCIMcNsc+u3KGtFo=";
  };

  cargoHash = "sha256-ink1qZD/ujLi/PlJRej5rByBka5a6pPVMP+Y1YlTE1c=";

  meta = {
    mainProgram = "kak-tree-sitter";
  };
}
