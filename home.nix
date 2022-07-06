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

  #programs.emacs = {
  #enable = true;
  #};
  #services.emacs = {
  #enable = true;
  #client.enable = true;
  #};
  #programs.direnv = {
  #enable = true;
  #enableNixDirenvIntegration = true;
  #};

  # xdg.configFile."mimeapps.list".text = ''
  #   [Default Applications]
  #   text/html=browser-select.desktop
  #   x-scheme-handler/http=browser-select.desktop
  #   x-scheme-handler/https=browser-select.desktop
  #   x-scheme-handler/about=browser-select.desktop
  #   x-scheme-handler/mailto=thunderbird.desktop;
  #   x-scheme-handler/unknown=browser-select.desktop
  #   image/png=sxiv.desktop
  #   image/jpeg=sxiv.desktop
  # '';

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
    ".config/picom.conf".source = ./config/picom.conf;
    ".wyrdrc".source = ./config/remind/.wyrdrc;
    "scripts".source = ./scripts;
  };
}
