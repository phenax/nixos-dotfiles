{ pkgs, config, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = [
    localPkgs.sensible-apps
    localPkgs.shotkey
    localPkgs.dwm
    localPkgs.dwmblocks
    localPkgs.st
    localPkgs.dmenu
    localPkgs.anypinentry
    localPkgs.bslock
  ];

  devPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ctags
    fzf

    nodejs-15_x
    python3
    rustup
    ghc

    rnix-lsp
    ccls
    haskell-language-server
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    firefox
    brave

    # Media
    mpv
    sxiv
    youtube-dl
    imagemagick
    ffmpeg-full
    feh
    w3m
    mtm
    lf
    dunst
    gotop
    tremc
  ];

  utils = with pkgs; [
    libnotify
    xcwd
    alsaUtils
    unzip
    curl
    jq
    wget
    killall
    inxi
    pciutils
    udiskie
    # picom
    # nm-applet

    # X stuff
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    xorg.xbacklight
    xclip
  ];
in {
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  # Security wrappers
  security.wrappers = {
    bslock.source = "${localPkgs.bslock}/bin/bslock";
  };
}
