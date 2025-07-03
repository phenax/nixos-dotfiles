{ pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ./hardware/thinkpad-e14
    ./packages.nix
    ./overlays-system.nix
    ./modules/login.nix
    ./modules/torrent.nix
    ./modules/work.nix
    ./modules/keyboard
    ./modules/clamav.nix
    ./modules/lockscreen.nix
    ./modules/sound
    ./modules/notifications
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  services.udisks2.enable = true;

  programs.dconf.enable = true;

  programs.nix-ld.enable = true;

  # Fix hmr issue
  systemd.extraConfig = ''DefaultLimitNOFILE=65536'';
  systemd.user.extraConfig = ''DefaultLimitNOFILE=65536'';
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;
  security.pam.loginLimits = [
    { domain = "*"; type = "-"; item = "nofile"; value = "65536"; }
  ];

  # NOTE: Enable bluetooth using this and then use bluetoothctl
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  # programs.kdeconnect.enable = true;

  # Network
  networking = {
    hostName = "smartfridge";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 3000 3001 8081 ];
      allowedUDPPorts = [ 41641 ];
    };
    nameservers = [ "100.100.100.100" "1.1.1.1" "8.8.8.8" ];
    search = [ "resolve.construction" ];
    networkmanager.enable = true;
    hosts = {
      "127.0.0.1" = ["phenax.local" "field.shape-e2e.com"];
    };
  };

  services.atd.enable = true;

  # programs.darling.enable = true; # macos emu
  virtualisation = {
    docker = {
      enable = true;
    };
    lxd.enable = false;
    virtualbox.host.enable = false;
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
    # anbox.enable = true;
  };
  services.spice-vdagentd.enable = true;

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = (with pkgs; [
      xdg-desktop-portal
      # xdg-desktop-portal-gtk
      xdg-desktop-portal-xapp
    ]);
    config = {
      common.default = "*";
    };
  };

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.xkb.layout = "us";

  # X11 config
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
  };
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = false;
    };
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    cozette
    noto-fonts-emoji
    inter
    roboto
    vistafonts
  ];

  services.logind = {
    powerKey = "ignore";
    rebootKey = "ignore";
    lidSwitch = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "ignore";
    hibernateKey = "ignore";
    suspendKey = "ignore";
  };

  # Home manager
  home-manager.useGlobalPkgs = true;
  home-manager.users.imsohexy = { pkgs, ... }: {
    imports = [ ./home.nix ];
    home = { stateVersion = "21.03"; };
  };

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
