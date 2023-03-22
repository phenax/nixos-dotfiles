{ stdenv, pkgs, fetchFromGithub, rustPlatform, lib, wrapQtAppsHook, qtbase, makeWrapper }:
with pkgs.lib;

let
  commitHash = "main";

  sidekickSrc = pkgs.fetchFromGitHub {
    owner = "phenax";
    repo = "sidekick-dashboard";
    rev = "main";
    # sha256 = lib.fakeSha256;
    sha256 = "sha256-1EJv0N1Ebp5vHN2+xETx4qhPQTS4YI6r3ysCkn0GozY=";
  };

  sidekickPkg = import "${sidekickSrc.out}/default.nix" {
    inherit pkgs;
    sourceRoot = replaceStrings [ "/nix/store/" ] [ "" ] "${sidekickSrc.out}";
  };
in
sidekickPkg
