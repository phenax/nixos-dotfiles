{ stdenv, pkgs, fetchFromGithub, rustPlatform, lib, wrapQtAppsHook, qtbase, makeWrapper }:
with pkgs.lib;

let
  useFakeHash = false;
  commitHash = "f160ec9742cacd14f8853ea6d17dc4011f85156d";
  realSha256 = "sha256-LCFcX23dY7tFoXPgEHaD+U6g2X/9M4aE4TPfvhu6bLI=";

  src = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "15b7a05f20aab51c4ffbefddb1b448e862dccb7d"; # 10th April 2022
    sha256 = "sha256-YeN4bpPvHkVOpQzb8APTAfE7/R+MFMwJUMkqmfvytSk=";
  };
  moz = import "${src.out}/rust-overlay.nix" pkgs pkgs;
  rust = moz.latest.rustChannels.nightly.rust.override {
    extensions = [ "rust-src" ];
  };
in
rustPlatform.buildRustPackage rec {
  pname = "sidekick-dashboard";
  version = "0.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "phenax";
    repo = "sidekick-dashboard";
    rev = commitHash;
    sha256 =
      if useFakeHash
      then lib.fakeSha256
      else realSha256;
  };

  cargoSha256 = "sha256-dgW2SlpKovw79wkdGcbVm6c8KqkbcZlvZCwCcdVBShw=";

  nativeBuildInputs = with pkgs; [ cmake wrapQtAppsHook clang ];
  buildInputs = with pkgs; [
    pkg-config
    libclang
    libGL
    qt5.full
    qtbase
    libsForQt5.qmake
    makeWrapper
  ];
}
