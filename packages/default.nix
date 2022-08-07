{ pkgs }:
{
  dmenu = pkgs.callPackage ./dmenu/pkg.nix { };
  bslock = pkgs.callPackage ./bslock/pkg.nix { };
  sensible-apps = pkgs.callPackage ./sensible-apps/pkg.nix { };
  shotkey = pkgs.callPackage ./shotkey/pkg.nix { };
  dwm = pkgs.callPackage ./dwm/pkg.nix { };
  dwmblocks = pkgs.callPackage ./dwmblocks/pkg.nix { };
  st = pkgs.callPackage ./st/pkg.nix { };
  anypinentry = pkgs.callPackage ./anypinentry/pkg.nix { };
  xmonad = pkgs.callPackage ./xmonad/pkg.nix { };
  sidekick = pkgs.libsForQt5.callPackage ./sidekick-dashboard/pkg.nix { };
}
