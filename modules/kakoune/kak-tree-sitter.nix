{ lib, pkgs }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "kak-tree-sitter";
  version = "3.0.0-local";

  src = fetchFromSourcehut {
    owner = "~hadronized";
    repo = "kak-tree-sitter";
    rev = "cdcfb42da9affd9dd0db9e8df1173731c61e3d9f"; # 27 Oct 2025
    hash = "sha256-Q8R++fEJMZFftiI9zGjwF7X8mek2oc40Yl9WMUtQWEA=";
  };

  cargoHash = "sha256-lZNM5HqICP6JfaMiBjACcUNRTTTIRhq2ou8cOLU0yOU=";

  meta = {
    mainProgram = "kak-tree-sitter";
  };
}
