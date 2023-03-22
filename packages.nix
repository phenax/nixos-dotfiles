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
    # bslock
    sidekick
  ];

  devPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ctags
    fzf
    docker-compose
    gibo
    direnv
    gh

    gcc
    gnumake
    nodejs-16_x

    # godot

    bspwm
    sxhkd

    rnix-lsp
    efm-langserver

    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.vscode-langservers-extracted
    nodePackages.tsun
    # nodePackage.bash-language-server
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    brave
    # firefox
    # ungoogled-chromium

    # Comm
    # slack
    # signal-cli
    # signal-desktop

    # Media
    spotify
    mpv
    sxiv
    youtube-dl
    imagemagick
    ffmpeg-full
    feh
    obs-studio
    inkscape
    krita
    # blender

    # Gaming
    # chiaki

    # Scheduling
    remind
    wyrd

    # qjackctl
    # ardour
    pavucontrol
    easyeffects

    lf
    dunst
    gotop
    tremc
    zathura
    # (emojipick.override {
    #   dmenu = localPkgs.dmenu;
    #   python3 = python3;
    #   emojipick-print-emoji = false;
    #   emojipick-font-family = "JetBrainsMono Nerd Font";
    #   emojipick-font-size = "12";
    # })
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
    fd
    sad
    mediainfo
    poppler_utils
    glow
    wineWowPackages.stable
    # appimage-run

    # Audio
    alsa-utils

    # X stuff
    picom
    brightnessctl
    xorg.xinit
    xorg.xrandr
    arandr
    xorg.xmodmap
    xorg.xkill
    xclip
    xdo
    xdotool
  ];
in
{
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils ++ [ pkgs.steam-run ];

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
    "qtwebkit-5.212.0-alpha4"
  ];

  programs.adb.enable = true;

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;

  # Security wrappers
  # security.wrappers = {
  #   bslock = {
  #     owner = config.users.users.imsohexy.name;
  #     group = "users";
  #     source = "${localPkgs.bslock}/bin/bslock";
  #   };
  # };
}
