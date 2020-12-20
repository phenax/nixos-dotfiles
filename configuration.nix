# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # Packages
  dmenu = pkgs.callPackage ./packages/dmenu/pkg.nix {};
  sensible-apps = pkgs.callPackage ./packages/sensible-apps/pkg.nix {};
  shotkey = pkgs.callPackage ./packages/shotkey/pkg.nix {};
  dwm = pkgs.callPackage ./packages/dwm/pkg.nix {};
  st = pkgs.callPackage ./packages/st/pkg.nix {};

  # Config
  apps = (import ./packages/sensible-apps/sensible-apps.nix).apps;
  windowManagers = {
    dwm = ''
      while true; do
        (ssh-agent dwm &>> /tmp/dwm.log) || break;
      done
    '';
  };
in {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  # Network
  networking.hostName = "dickhead";
  networking.networkmanager.enable = true;

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";

  # Global
  environment.variables = {
    EDITOR = apps.EDITOR;
    VISUAL = apps.EDITOR;
    TERMINAL = apps.TERMINAL;
    BROWSER = apps.BROWSER;
    PRIVATE_BROWSER = apps.PRIVATE_BROWSER;
  };

  environment.shells = [ pkgs.zsh pkgs.bashInteractive ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histFile = "~/.config/zshhistory";
    histSize = 50000;
    interactiveShellInit = ''source ~/nixos/external/zsh/zshrc'';
    promptInit = "";
    loginShellInit = ''
      setup_dwm() {
        echo "~/nixos/external/xconfig/init.sh; ${windowManagers.dwm}" > ~/.xinitrc;
      }

      case "$(tty)" in
        /dev/tty1) setup_dwm && startx ;;
        *) echo "No tty for u" ;;
      esac;
    '';
  };

  # X11 config
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    libinput = {
      enable = true;
      tapping = true;
      naturalScrolling = false;
    };
  };
  fonts.fonts = with pkgs; [
    jetbrains-mono
    cozette
    noto-fonts-emoji
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # User
  users.users.imsohexy = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "audio"
      "video"
      "storage"
      "git"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  # Nix config
  nixpkgs.overlays = [
    (import ./external/nvim/neovim.nix)
    (self: super: {
      pass = super.pass.override { dmenu = dmenu; };
    })
  ];

  # Packages
  environment.systemPackages = with pkgs; [
    # Dev
    neovim
    silver-searcher
    ripgrep
    ctags
    fzf
    git
    nodejs-15_x
    yarn

    # Browser
    firefox
    brave
    # qutebrowser
    w3m

    # X
    xorg.xinit
    xorg.xrandr
    xorg.xmodmap

    # Media
    mpv
    sxiv
    feh
    ffmpeg-full

    # Custom packages
    sensible-apps
    shotkey
    dwm
    st
    dmenu

    # Utils
    mtm
    lf
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
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

