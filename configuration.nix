# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./packages.nix
    ./overlays-system.nix
    ./modules/login.nix
    ./modules/torrent.home.nix
    ./modules/work.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  services.tlp = {
    enable = true;
  };

  hardware.bluetooth.enable = false;
  #hardware.bluetooth.package = pkgs.bluezFull;

  services.monero = {
    enable = false;
    dataDir = "/var/lib/monero";
    # mining.enable = {
    #   enable = false;
    #   threads = 2;
    # };
    rpc = {
      address = "127.0.0.1";
      port = 18081;
      # user = "hexyman";
      # password = "";
    };
  };

  # Enable sound.
  sound.enable = true;
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
    };
  };

  # Network
  networking = {
    hostName = "dickhead";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 ];
      allowedUDPPorts = [];
    };
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1       dev.parlezvous.io
      127.0.0.1       demo.parlezvous.io
    '';
  };

  services.atd.enable = true;

  virtualisation = {
    docker.enable = true;
    lxd.enable = true;
  };

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";

  # Home manager
  home-manager.users.imsohexy = { pkgs, ... }: {
    imports = [ ./home.nix ];
    home = { stateVersion = "21.03"; };
  };

  # X11 config
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = false;
      };
    };
  };
  fonts.fonts = with pkgs; [
    # jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cozette
    noto-fonts-emoji
  ];

  nix.autoOptimiseStore = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  system.stateVersion = "20.09";
}
