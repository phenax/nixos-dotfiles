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

  # Network
  networking.hostName = "dickhead";
  networking.networkmanager.enable = true;

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";

  # Global
  environment.variables = {
    EDITOR = "nvim";
    SHELL = "zsh";
    VISUAL = "nvim";
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
    interactiveShellInit = "source ~/nixos/external/zsh/zshrc";
    promptInit = "";
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
    # xkbOptions = "eurosign:e";
  };

  # nixpkgs.config.packageOverrides = pkgs: {
  #   dwm = pkgs.dwm.overrideAttrs (_: {
  #     src = builtins.fetchGit {
  #       url = "https://github.com/phenax/dwm";
  #       ref = "master";
  #     };
  #   }); 
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # User
  users.users.imsohexy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "audio" "video" "storage" "git" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Nix config
  nixpkgs.overlays = [ (self: super: {
    tree-sitter-updated = super.tree-sitter.overrideAttrs(oldAttrs: {
      postInstall = ''
        PREFIX=$out make install;
      '';
    });
    neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
      name = "neovim-nightly";
      version = "0.5-nightly";
      src = self.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "nightly";
        sha256 = "0vpjdd32lgzyh85gyazqpms8vmaad6px3zx2svdxhvcdxgschqz9";
      };

      nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
    });
  })];


  # Packages
  environment.systemPackages = with pkgs; [
    vim
    neovim
    silver-searcher
    ripgrep
    fzf
    git
    nodejs-15_x
    yarn

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

    pass
    alsaUtils
    unzip
    curl
    wget
    gotop
    killall
    inxi
    pciutils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
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

