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
    docker-compose
    direnv
    rlwrap
    # gitu
    # Switch to gitu later. This is to get around breaking package (1 Feb 2026)
    (rustPlatform.buildRustPackage rec {
      pname = "gitu";
      version = "0.40.0-dev";
      src = fetchFromGitHub {
        owner = "altsem";
        repo = "gitu";
        rev = "6d16d79c29cf1bf9d6c447e1d1a28c3d56da110a";
        hash = "sha256-zdoAfMs3JZkrpNg81V9ucF2khliuBFPr8VlvY2qEmos=";
      };
      cargoHash = "sha256-dmhaef9DoqUuD2YQtFBNjkYv+MpwaTnHfOUrAwqV6ao=";
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ libgit2 openssl zlib ];
      nativeCheckInputs = [ git ];
    })
    # gh
    just
    difftastic
    yq-go
    babashka
    # hurl
    # delta
    # gibo

    gcc
    gnumake
    nodejs_24
    bun
    nodePackages.typescript

    # bspwm
    # sxhkd
    android-tools

    nixd
    nixfmt
    lua-language-server
    ((fennel-ls.override { lua = lua5_1; luaPackages = lua51Packages; }).overrideAttrs (self: {
      version = "0.2.2";
      src = pkgs.fetchFromSourcehut {
        owner = "~xerool";
        repo = "fennel-ls";
        rev = "cd9821cd80e7e4db8bbed388cbaf17473cd54ba3";
        hash = "sha256-3qX77hZjO/rNOO58cG9yGFVFQDYaeJdDEhbjNTIIQys=";
      };
    }))
    fnlfmt
    efm-langserver
    marksman
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    # biome

    lua5_1
    luajit
    luajitPackages.luarocks
    luajitPackages.lua-curl
    luajitPackages.magick
    luajitPackages.fennel
  ];

  apps = with pkgs; [
    # Browser
    qutebrowser
    brave
    chromium

    # Media
    sxiv
    yt-dlp
    imagemagick
    ffmpeg-full
    feh
    zathura

    inkscape
    kicad
    # obs-studio
    # krita
    # blender

    # luanti
    # xonotic
    # openarena
    # chiaki # PS remote play
    # rpcs3
    # rusty-psn

    remind
    dunst

    # TUI stuff
    # lf
    bottom
    tremc
    wyrd
    dua
    # newsboat

    # (builtins.getFlake "github:phenax/chelleport/bf57e4968d059b207c036b57818a58ed8c54d141").packages.x86_64-linux.default
    # (builtins.getFlake "github:phenax/draw-stuff-on-your-screen/6e0e1f6ee603045cac5bb5d9d75d80c9ddef6c6e").packages.x86_64-linux.default
    # (pkgs.writeShellScriptBin "null-browser" ''exec /home/imsohexy/dev/projects/null-browser/result/bin/null-browser "$@"'')
  ];

  utils = with pkgs; [
    libnotify
    xcwd
    unzip
    zip
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
    fzf
    w3m
    ed
    moreutils
    # sad
    mediainfo
    poppler-utils
    epub2txt2
    glow
    pkgs.steam-run
    flatpak
    distrobox

    # FIXME: wine broken: 19 April 25
    # (import (
    #   builtins.fetchTarball {
    #     url = "https://github.com/NixOS/nixpkgs/archive/21808d22b1cda1898b71cf1a1beb524a97add2c4.tar.gz";
    #   }
    # ) {}).wineWow64Packages.stable
    wineWow64Packages.stable

    # X stuff
    picom
    brightnessctl
    xinit
    xrandr
    xmodmap
    xkill
    xhost
    xclip
    xdo
    xdotool
    wmctrl
    arandr
    xgamma
    v4l-utils
    hsetroot

    libva
    libdrm
    pkg-config

    fatsort
    lsof
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
  ];
in
{
  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;

  nixpkgs.config.permittedInsecurePackages = [
    # "ffmpeg-3.4.8"
    # "qtwebkit-5.212.0-alpha4"
    # "qtwebengine-5.15.19"
  ];

  # environment.variables = {
  #   CURL_DIR = lib.makeLibraryPath [pkgs.curl];
  # };

  # programs.steam.enable = true;
  # hardware.steam-hardware.enable = true;
  # programs.gamemode.enable = true;

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
