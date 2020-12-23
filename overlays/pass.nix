self: super:
let
  localPkgs = import ../packages/default.nix { pkgs = super.pkgs; };
in {
  pass = super.pass.override {
    dmenu = localPkgs.dmenu;
  };
}
