self: super:
let
  localPkgs = import ../packages/default.nix { pkgs = super.pkgs; };
in
{
  j4-dmenu-desktop = super.j4-dmenu-desktop.override {
    dmenu = localPkgs.dmenu;
  };
}
