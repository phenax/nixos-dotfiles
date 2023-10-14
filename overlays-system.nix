{ pkgs, ... }:
let
  overlays = import ./overlays/default.nix { };
in
{
  nixpkgs.overlays = with overlays; [
    # neovim-nightly
    qutebrowser
    j4-dmenu-desktop
  ];
}
