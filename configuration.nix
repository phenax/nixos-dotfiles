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
    ./modules/keyboard/default.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  services.tlp = {
    enable = true;
  };

  services.udisks2.enable = true;

  programs.dconf.enable = true;

  # services.borgbackup =
  #   let
  #     homeDir = config.users.users.imsohexy.home;
  #     user = config.users.users.imsohexy.name;
  #   in
  #   {
  #     jobs = {
  #       testBkup = {
  #         paths = "${homeDir}/dump/elm-worker-tmp";
  #         repo = "${homeDir}/dump/backups";
  #         compression = "none";
  #         startAt = "weekly";
  #         user = user;
  #         group = "users";
  #         encryption = {
  #           mode = "none";
  #         };
  #         # encryption = {
  #         #   mode = "repokey";
  #         #   passCommand = "pass show BorgBackup/imsohexy";
  #         # };
  #       };
  #     };
  #   };

  hardware.bluetooth.enable = false;
  # services.blueman.enable = true;

  # Enable sound.
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # jack.enable = true;
    # alsa.support32Bit = true;
  };

  # Network
  networking = {
    hostName = "dickhead";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 ];
      allowedUDPPorts = [ ];
    };
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1       phenax.local
      127.0.0.1       hasura.colabra
    '';
  };

  services.atd.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      # autoPrune = {
      #   enable = true;
      #   flags = [ "--volumes" ];
      # };
    };
    lxd.enable = false;
    virtualbox.host.enable = false;
    #anbox.enable = true;
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
    videoDrivers = [ "intel" "modesetting" ];
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

  nix.settings.auto-optimise-store = true;
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
