# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  networking.hostName = "dickhead";
  networking.networkmanager.enable = true;

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";

  environment.variables = {
    EDITOR = "nvim";
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

  # nixpkgs.config.packageOverrides = pkgs: {
  #   dwm = pkgs.dwm.overrideAttrs (_: {
  #     src = builtins.fetchGit {
  #       url = "https://github.com/phenax/dwm";
  #       ref = "master";
  #     };
  #   }); 
  # };

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # User
  users.users.imsohexy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "audio" "video" "storage" "git" "networkmanager" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    silver-searcher
    ripgrep
    fzf
    git

    dwm
    st

    mtm
    xorg.xinit
    firefox
    w3m
    xorg.xrandr

    mpv
    sxiv
    feh
    ffmpeg-full

    unzip
    curl
    wget
    ytop
    killall
    inxi
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

