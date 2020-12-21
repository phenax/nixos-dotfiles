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
    yarn

    nodejs-15_x
    python3
    rustup
    ghc

    rnix-lsp
    ccls
    haskell-language-server
    # nodePackages.bash-language-server
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    firefox
    brave

    # Media
    mpv
    sxiv
  ];

  utils = with pkgs; [
    w3m
    lf
    libnotify
    dunst
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
    # picom
    ffmpeg-full
    # nm-applet

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
    (import ./external/qutebrowser/overlay.nix)
    (self: super: {
      pass = super.pass.override { dmenu = dmenu; };
    })
  ];

  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;
}
