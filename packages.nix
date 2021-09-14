{ pkgs, config, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = with localPkgs; [
    sensible-apps
    shotkey
    xmonad
    # dwm
    # dwmblocks
    st
    dmenu
    anypinentry
    bslock

    # Not local
    #pkgs.bspwm
  ];

  devPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ctags
    fzf
    git-bug
    docker-compose

    gcc
    gnumake
    nodejs-16_x
    python3
    # rustup

    godot
    blender

    rnix-lsp
    # python-language-server
    #haskell-language-server # Broken on 8-Sept-2021
    ghc
    # cabal-install
  ] ++ (
    with pkgs.nodePackages; [
      typescript
      typescript-language-server
      vscode-json-languageserver
      # bash-language-server
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
    #monero-gui

    # Scheduling
    remind
    wyrd

    # signal-cli
    # signal-desktop
    lf
    dunst
    gotop
    tremc
    zathura
  ];


  utils = with pkgs; [
    libnotify
    xcwd
    unzip
    curl
    jq
    wget
    killall
    pciutils
    udiskie
    file
    at
    bc

    # Audio
    alsaUtils
    qjackctl
    qsynth
    ardour

    # X stuff
    picom
    brightnessctl
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    xorg.xkill
    xclip
    xdo
    xdotool
  ];
in
{
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
  ];

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Security wrappers
  security.wrappers = {
    bslock.source = "${localPkgs.bslock}/bin/bslock";
  };
}
