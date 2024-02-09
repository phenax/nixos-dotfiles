{ pkgs, config, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = with localPkgs; [
    sensible-apps
    shotkey
    # xmonad
    dwm
    dwmblocks
    st
    dmenu
    anypinentry
    # bslock
    # sidekick
  ];

  devPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ast-grep
    ctags
    fzf
    docker-compose
    direnv
    gh
    just
    # gibo

    gcc
    gnumake
    nodejs_20

    # bspwm
    # sxhkd

    rnix-lsp
    lua-language-server
    efm-langserver

    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    # qutebrowser-qt5
    brave
    # firefox
    # ungoogled-chromium

    # Comm
    slack

    # Media
    spotify
    sxiv
    youtube-dl
    imagemagick
    ffmpeg-full
    feh
    obs-studio
    inkscape
    # krita
    zathura
    blender
    j4-dmenu-desktop

    # chiaki # PS remote play

    remind
    dunst

    # Audio
    qjackctl
    ardour
    a2jmidid
    pavucontrol
    audacity
    # guitarix
    # easyeffects

    # TUI stuff
    lf
    gotop
    tremc
    wyrd
    dua
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
    file
    at
    bc
    bat
    catimg
    fd
    # sad
    mediainfo
    poppler_utils
    glow
    # figlet
    wineWowPackages.stable
    pkgs.steam-run
    flatpak
    distrobox
    # appimage-run

    # Audio
    alsa-utils

    # X stuff
    picom
    brightnessctl
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap
    xorg.xkill
    xorg.xhost
    xclip
    xdo
    xdotool
    arandr
    xorg.xgamma

    v4l-utils
  ];
in
{
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
    "qtwebkit-5.212.0-alpha4"
  ];

  programs.adb.enable = true;

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;

  programs.darling.enable = true;

  # Security wrappers
  # security.wrappers = {
  #   bslock = {
  #     owner = config.users.users.imsohexy.name;
  #     group = "users";
  #     source = "${localPkgs.bslock}/bin/bslock";
  #   };
  # };
}
