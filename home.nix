{ config, pkgs, epkgs, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in
{
  imports = [
    ./overlays-home.nix
    ./modules/music.home.nix
    ./modules/git.home.nix
    ./modules/git.home.nix
    ./modules/xresources.home.nix
  ];

  home.packages = with pkgs; [
    yarn
  ];

  programs.emacs = {
    enable = true;
  };
  services.emacs = {
    enable = true;
    client.enable = true;
  };
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  services.syncthing = {
    enable = true;
    tray = false;
  };

  services.unclutter = {
    enable = true;
    timeout = 5;
  };

  services.udiskie = {
    enable = true;
    tray = "always";
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    settings = {
      PASSWORD_STORE_DIR = "~/.config/password-store";
    };
  };
  services.gpg-agent = {
    enable = true;
    maxCacheTtl = 864000;
    defaultCacheTtl = 864000;
    enableSshSupport = false;
    #pinentryFlavor = null;
    #extraConfig = ''
    #pinentry-program /home/imsohexy/nixos/packages/anypinentry/source/anypinentry
    #'';
  };

  # services.network-manager-applet.enable = true;

  home.file = {
    ".config/xorg".source = ./config/xorg;
    ".config/zsh".source = ./config/zsh;
    ".config/nvim".source = ./config/nvim;
    ".config/qutebrowser".source = ./config/qutebrowser;
    ".config/sxiv".source = ./config/sxiv;
    ".local/share/qutebrowser/userscripts".source = ./config/qutebrowser/userscripts;
    ".local/share/qutebrowser/greasemonkey".source = ./config/qutebrowser/greasemonkey;
    # ".local/share/qutebrowser/sessions".source = ./private-config/qutebrowser/sessions;
    ".config/dunst".source = ./config/dunst;
    ".config/lf".source = ./config/lf;
    #"Pictures/wallpapers".source = ./extras/wallpapers;
    "scripts".source = ./scripts;
  };

  #services.picom = {
  #enable = true;
  #backend = "glx";
  #inactiveDim = "0.3";
  #opacityRule = [
  #"98:class_g = 'St' && focused"
  #"85:class_g = 'St' && !focused"
  #"90:class_g = 'qutebrowser' && !focused"
  #"100:class_g = 'qutebrowser' && focused"
  #];
  #extraOptions = ''
  #focus-exclude = [ "class_g = 'dwm'", "class_g = 'dmenu'"];
  #'';
  #menuOpacity = "0.9";
  #};
}
