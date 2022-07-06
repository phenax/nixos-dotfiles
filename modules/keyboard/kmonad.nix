{ pkgs, ... }:
let
  kmonadVersion = "0.4.1";
  # kmonadNixRev = "ac3c0db4f7fca0f66980d1b76a64630a66a36c21";

  kmonadBin = pkgs.fetchurl {
    url = "https://github.com/kmonad/kmonad/releases/download/${kmonadVersion}/kmonad-${kmonadVersion}-linux";
    sha256 = "sha256-g55Y58wj1t0GhG80PAyb4PknaYGJ5JfaNe9RlnA/eo8=";
  };

  kmonadPkg = pkgs.runCommand "kmonad" { }
    ''#!${pkgs.stdenv.shell}
      mkdir -p $out/bin
      cp ${kmonadBin} $out/bin/kmonad
      chmod +x $out/bin/*
    '';

  # kmonadGit = builtins.fetchTarball {
  #   url = "https://github.com/kmonad/kmonad/archive/${kmonadNixRev}.tar.gz";
  #   sha256 = "sha256:0pjb8971f7z27w7py4n0zm8acjpylj7wz7vx8iz3i7qmj6k45c2y";
  # };
in
{
  imports = [
    ./kmonad-nixos-module.nix
    # "${kmonadGit}/nix/nixos-module.nix"
  ];

  services.kmonad = {
    package = kmonadPkg;
  };
}
