{ pkgs, ... }:
let
  overlays = import ./overlays/default.nix { };
in
{
  nixpkgs.overlays = with overlays; [
    pass-with-dmenu

    # Home manager issue {https://discourse.nixos.org/t/error-when-upgrading-nixos-related-to-fcitx-engines/26940}
    (self: super: {
      fcitx-engines = super.fcitx5;
    })
  ];
}
