{ stdenv, pkgs, fetchFromGithub, rustPlatform, lib, wrapQtAppsHook, qtbase, makeWrapper }:
with pkgs.lib;

let
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
    rev = "994450070a984448cb0b286fc729a92c6487c0c9";
    sha256 = "sha256-M4mbep/qxRsRxZdILxKY5ejRPVZ3Pm6nuToDCZky/A0=";
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
