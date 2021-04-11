{ pkgs, config, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = with localPkgs; [
    sensible-apps
    shotkey
    dwm
    dwmblocks
    st
    dmenu
    anypinentry
    bslock
  ];

  devPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ctags
    fzf

    gcc
    gnumake
    nodejs-15_x
    python3
    rustup

    rnix-lsp
    python-language-server
    # haskell-language-server
    # cabal-install
    # ghc
  ] ++ (
    with pkgs.nodePackages; [
      typescript
      typescript-language-server
      bash-language-server
    ]
  );

  apps = with pkgs; [
    # Browser
    qutebrowser
    brave

    # Media
    mpv
    sxiv
    youtube-dl
    imagemagick
    ffmpeg-full
    feh

    # Remind
    remind
    wyrd

    signal-cli
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
    pciutils
    udiskie
    file
    at

    # X stuff
    bc
    brightnessctl
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    #xorg.xbacklight
    xclip
    xdo
    xdotool
  ];
in
{
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  # Security wrappers
  security.wrappers = {
    bslock.source = "${localPkgs.bslock}/bin/bslock";
  };
}
