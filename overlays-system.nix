{ pkgs, ... }:
let
  overlays = import ./overlays/default.nix { };
in
{
  nixpkgs.overlays = with overlays; [
    pass-with-dmenu
    qutebrowser
    j4-dmenu-desktop
    # neovim-nightly
  ];
}
