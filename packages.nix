{ config, pkgs, ... }:

let
  dmenu = pkgs.callPackage ./packages/dmenu/pkg.nix {};
  customPackages = [
    (pkgs.callPackage ./packages/sensible-apps/pkg.nix {})
    (pkgs.callPackage ./packages/shotkey/pkg.nix {})
    (pkgs.callPackage ./packages/dwm/pkg.nix {})
    (pkgs.callPackage ./packages/dwmblocks/pkg.nix {})
    (pkgs.callPackage ./packages/st/pkg.nix {})
    dmenu
  ];

  devPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ctags
    fzf
    git
    nodejs-15_x
    yarn
    python3
  ];

  apps = with pkgs; [
    # Browser
    # qutebrowser
    firefox
    brave
    w3m

    # Media
    mpv
    sxiv
  ];

  utils = with pkgs; [
    mtm
    lf
    pass
    xcwd
    alsaUtils
    unzip
    curl
    wget
    gotop
    killall
    inxi
    pciutils
    udiskie
    feh
    ffmpeg-full

    # X stuff
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    xorg.xbacklight
  ];
in {
  # Overlays
  nixpkgs.overlays = [
    (import ./external/nvim/neovim.nix)
    (self: super: {
      pass = super.pass.override { dmenu = dmenu; };
    })
  ];

  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;
}
