{ lib, pkgs }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "kakoune-lsp";
  version = "19.0.1-local.0";

  src = fetchFromGitHub {
    owner = "kakoune-lsp";
    repo = "kakoune-lsp";
    rev = "a0b9232dfec86c7c87388128c4592d921ee21988"; # 24 May 2026
    hash = "sha256-uGyjLx5iFsnzFNx8TnojQkQrbwhAUcor9l6gFS76vIk=";
  };

  cargoHash = "sha256-RoyAxWT+GT1Oz0q+9UE4yAoMHp05CMmR6fYUb5+Ku9U=";

  meta = {
    mainProgram = "kak-lsp";
  };
}
