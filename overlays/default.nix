{ pkgs, ... }:
{
  # Overlays
  nixpkgs.overlays = [
    (import ./neovim.nix)
    (import ./qutebrowser.nix)
    (import ./pass.nix)
  ];
}
