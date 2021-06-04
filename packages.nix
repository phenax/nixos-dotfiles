{ pkgs, config, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = with localPkgs; [
    sensible-apps
    shotkey
    # dwm
    # dwmblocks
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
    git-bug

    gcc
    gnumake
    nodejs-16_x
    python3
    # rustup

    godot
    blender

    rnix-lsp
    # python-language-server
    haskell-language-server
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

    # Remind
    # remind
    # wyrd

    # signal-cli
    # signal-desktop
    lf
    dunst
    gotop
    tremc
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

    # Audio
    alsaUtils
    qjackctl
    qsynth
    ardour

    # X stuff
    bc
    brightnessctl
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    # xorg.xkill
    #xorg.xbacklight
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

  # Security wrappers
  security.wrappers = {
    bslock.source = "${localPkgs.bslock}/bin/bslock";
  };
}
