# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl.extraPackages = with pkgs; [ intel-compute-runtime ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dickhead"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Configure keymap in X11
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.synaptics.enable = true;
  services.xserver.libinput = {
    enable = true;
    tapping = true;
    naturalScrolling = true;
  };
  # services.xserver.videoDrivers = ["modesetting"];
  # services.xserver.useGlamor = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;

  #nixpkgs.overlays = [ (self: super: {
  #  dwm = super.dwm.overrideAttrs (_: {
  #    src = builtins.fetchGit https://github.com/phenax/dwm;
  #  });
  #}) ];  

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.imsohexy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "audio" "video" "storage" "git" "networkmanager" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim
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
    silver-searcher
    ripgrep
    fzf
    ffmpeg-full
    unzip
    git
    curl
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

