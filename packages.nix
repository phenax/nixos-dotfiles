{ pkgs, config, lib, ... }:

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
    ed
    rlwrap
    # gh
    just
    difftastic
    # hurl
    # delta
    # gibo

    gcc
    gnumake
    nodejs_24
    bun

    # bspwm
    # sxhkd

    nixd
    lua-language-server
    efm-langserver

    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    biome

    lua5_1
    lua51Packages.luarocks
    lua51Packages.lua-curl
    luajitPackages.magick # lua51Packages.magick
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    # nodePackages."@mozilla/readability"
    # nodePackages.jsdom
    # nodePackages.qutejs

    # qutebrowser-qt5
    brave
    # firefox
    # ungoogled-chromium

    # Comm
    slack

    # Media
    # spotify
    sxiv
    yt-dlp
    imagemagick
    ffmpeg-full
    feh
    # obs-studio
    inkscape
    krita
    zathura
    blender
    j4-dmenu-desktop

    # chiaki # PS remote play

    tgpt
    remind
    dunst
    newsboat

    # Audio
    qjackctl
    ardour
    fluidsynth
    a2jmidid
    pavucontrol
    audacity
    # guitarix
    # easyeffects

    # TUI stuff
    lf
    bottom
    tremc
    wyrd
    dua

    (builtins.getFlake "github:phenax/chelleport/5262d942c4c2c36529fbe704e7de165044e6dc99").packages.x86_64-linux.default
    (builtins.getFlake "github:phenax/draw-stuff-on-your-screen/6e0e1f6ee603045cac5bb5d9d75d80c9ddef6c6e").packages.x86_64-linux.default
    (pkgs.writeShellScriptBin
      "null-browser"
      ''exec /home/imsohexy/dev/projects/web-browser/result/bin/null-browser "$@"'')
  ];

  utils = with pkgs; [
    libnotify
    xcwd
    unzip
    p7zip
    unrar
    curl
    jq
    wget
    killall
    pciutils
    file
    at
    bc
    bat
    chafa
    kitty
    figlet
    fd
    # sad
    mediainfo
    poppler_utils
    glow
    pkgs.steam-run
    flatpak
    distrobox

    # FIXME: wine broken: 19 April 25
    (import (
      builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/21808d22b1cda1898b71cf1a1beb524a97add2c4.tar.gz";
      }
    ) {}).wineWowPackages.stable

    # wineWowPackages.stable
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
    wmctrl
    arandr
    xorg.xgamma
    v4l-utils

    libva
    libdrm
    pkg-config

    virt-manager
    virt-viewer
    spice 
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    adwaita-icon-theme
  ];
in
{
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
    "qtwebkit-5.212.0-alpha4"
  ];

  # environment.variables = {
  #   CURL_DIR = lib.makeLibraryPath [pkgs.curl];
  # };

  programs.adb.enable = true;

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
  programs.gamemode.enable = true;

  programs.alvr = {
    enable = false;
    openFirewall = false;
  };

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
