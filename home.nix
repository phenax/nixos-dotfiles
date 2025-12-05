{ pkgs, lib, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in
{
  imports = [
    ./overlays-home.nix
    ./modules/git.home.nix
    ./modules/mpv.home.nix
    ./modules/music/default.home.nix
    ./modules/xresources.home.nix
    # ./modules/newsboat.home
    ./modules/email.home
    ./modules/calendar.home
  ];

  home.packages = with pkgs; [
    yarn
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

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

  programs.obs-studio = {
    enable = true;
    # enableVirtualCamera = true;
    # package = pkgs.obs-studio.override {
    #   browserSupport = true;
    # };
    plugins = [
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      pkgs.obs-studio-plugins.obs-backgroundremoval
      # pkgs.obs-studio-plugins.obs-webkitgtk
    ];
  };

  services.syncthing = {
    enable = true;
    tray = { enable = false; };
  };

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "never";
  };
  systemd.user.services.udiskie = {
    Install.WantedBy = lib.mkForce [ "default.target" ];
    Unit.After = lib.mkForce [ "udisks2.service" ];
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
    # pinentryPackage = pkgs.pinentry-qt;
    pinentry.package = localPkgs.anypinentry;
    # extraConfig = ''
    #   pinentry-program ${localPkgs.anypinentry}/bin/anypinentry
    # '';
  };

  home.file = {
    ".config/xorg".source = ./config/xorg;
    ".config/zsh".source = ./config/zsh;
    ".config/nvim".source = ./config/nvim;
    ".config/qutebrowser".source = ./config/qutebrowser;
    ".config/sxiv".source = ./config/sxiv;
    ".local/share/qutebrowser/userscripts".source = ./config/qutebrowser/userscripts;
    ".local/share/qutebrowser/greasemonkey".source = ./config/qutebrowser/greasemonkey;
    ".config/dunst".source = ./config/dunst;
    # ".config/lf".source = ./config/lf;
    ".config/picom.conf".source = ./config/picom.conf;
    ".wyrdrc".source = ./config/remind/.wyrdrc;
    "scripts".source = ./scripts;
    ".config/bottom/bottom.toml".source = ./config/bottom.toml;
  };
}
