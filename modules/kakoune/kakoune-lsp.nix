{ lib, pkgs }:
with pkgs;
rustPlatform.buildRustPackage rec {
  pname = "kakoune-lsp";
  version = "19.0.1-local.0";

  src = fetchFromGitHub {
    owner = "kakoune-lsp";
    repo = "kakoune-lsp";
    rev = "5ac69fde4222fa458908ff0c17d3aa429c74e28a"; # 28 Feb 2026
    hash = "sha256-PjYPhzMoT8rE2XGI/O9SAcksv2XGyk682IbHJW5vusc=";
  };

  cargoHash = "sha256-nwxZwyT9sNoZuvvg/YJFlVshe6i+W9avmquq9iXmFVM=";

  meta = {
    mainProgram = "kak-lsp";
  };
}
