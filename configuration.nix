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

  services.tlp.enable = true;

  services.udisks2.enable = true;

  programs.dconf.enable = true;

  # Fix hmr issue?
  systemd.extraConfig = ''DefaultLimitNOFILE=65536'';
  systemd.user.extraConfig = ''DefaultLimitNOFILE=65536'';
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "65536";
    }
  ];

  # NOTE: Enable bluetooth using this and then use bluetoothctl
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  # services.vdirsyncer = {
  #   enable = true;
  #   jobs = {
  #     google_cal = {
  #       enable = true;
  #       config = {
  #         #
  #       };
  #     };
  #   };
  # };

  # Enable sound.
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Network
  networking = {
    hostName = "smartfridge";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 3000 3001 ];
      allowedUDPPorts = [ 41641 ];
    };
    nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
    search = [ "resolve.construction" ];
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1       phenax.local
      127.0.0.1       field.shape-e2e.com
    '';
  };
  services.tailscale.enable = true;

  services.atd.enable = true;

  virtualisation = {
    docker = {
      enable = true;
    };
    lxd.enable = false;
    virtualbox.host.enable = false;
    # anbox.enable = true;
  };
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = (with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-xapp
    ]);
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
  fonts.packages = with pkgs; [
    # jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cozette
    noto-fonts-emoji
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
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
