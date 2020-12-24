# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let 
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in {
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./packages.nix
    ./overlays-system.nix
    ./login.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  # Network
  networking = {
    hostName = "dickhead";
    networkmanager.enable = true;
    extraHosts = '''';
  };

  virtualisation.docker.enable = true;

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";

  # Home manager
  home-manager.users.imsohexy = { pkgs, ... }: {
    imports = [./home.nix];
    home = { stateVersion = "21.03"; };
  };

  services.transmission = {
    enable = true;
    settings = {
      "download-dir" = "/home/imsohexy/Downloads/dl";
      "download-queue-enabled" = true;
      "download-queue-size" = 5;
      "incomplete-dir" = "/home/imsohexy/Downloads/dl/incomplete";
      "incomplete-dir-enabled" = true;
      "peer-port" = 51413;
      "peer-port-random-high" = 65535;
      "peer-port-random-low" = 49152;
      "prefetch-enabled" = true;
      "rename-partial-files" = true;
      "rpc-authentication-required" = false;
      "rpc-bind-address" = "127.0.0.1";
      "rpc-enabled" = true;
      "rpc-port" = 9091;
      "rpc-whitelist-enabled" = true;
      "script-torrent-done-enabled" = false;
      "script-torrent-done-filename" = "";
      "start-added-torrents" = true;
      "trash-original-torrent-files" = false;
      "umask" = 18;
      "utp-enabled" = true;
      "watch-dir" = "/home/an/Downloads/qute";
      "watch-dir-enabled" = false;
    };
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
    # jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cozette
    noto-fonts-emoji
  ];
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  system.stateVersion = "20.09";
}
