{ pkgs, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
  customPackages = [
    localPkgs.sensible-apps
    localPkgs.shotkey
    localPkgs.dwm
    localPkgs.dwmblocks
    localPkgs.st
    localPkgs.dmenu
    #localPkgs.anypinentry
  ];

  # security.setuidPrograms = [ "bslock" ];
  # security.wrappers.bslock.source = "${bslock.out}/bin/bslock";

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
    mtm
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
      pass = super.pass.override { dmenu = localPkgs.dmenu; };
    })
  ];

  # Packages
  environment.systemPackages = devPackages ++ customPackages ++ apps ++ utils;
}
