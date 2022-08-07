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
    # blender

    bspwm
    sxhkd

    rnix-lsp
    efm-langserver

    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.vscode-langservers-extracted
    # nodePackage.bash-language-server
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    brave
    # ungoogled-chromium

    # Comm
    #slack
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

    # Scheduling
    remind
    wyrd

    #monero-gui
    lf
    dunst
    gotop
    tremc
    # zathura # Broken on 9th April 2020
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
    tty-clock

    # Audio
    alsaUtils
    pavucontrol
    obs-studio

    # qjackctl
    #qsynth
    # ardour

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
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  nixpkgs.config.permittedInsecurePackages = [
    "ffmpeg-3.4.8"
  ];

  programs = {
    adb.enable = true;
  };

  #programs.steam.enable = true;
  #hardware.steam-hardware.enable = true;

  # Security wrappers
  security.wrappers = {
    bslock = {
      owner = config.users.users.imsohexy.name;
      group = "users";
      source = "${localPkgs.bslock}/bin/bslock";
    };
  };
}
