{ config, pkgs, epkgs, lib, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in
{
  imports = [
    ./overlays-home.nix
    ./modules/music.home.nix
    ./modules/git.home.nix
    ./modules/xresources.home.nix
    ./modules/mpv.home.nix
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

  # programs.emacs = {
  #   enable = true;
  # };
  # services.emacs = {
  #   enable = true;
  #   client.enable = true;
  # };
  # programs.direnv = {
  #   enable = true;
  #   enableNixDirenvIntegration = true;
  # };

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
    plugins = [
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  services.easyeffects = {
    enable = true;
    # preset = "default";
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
    pinentryFlavor = "qt";
    # pinentryFlavor = null;
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
    ".config/lf".source = ./config/lf;
    ".config/picom.conf".source = ./config/picom.conf;
    ".wyrdrc".source = ./config/remind/.wyrdrc;
    "scripts".source = ./scripts;
    ".config/bottom/bottom.toml".source = ./config/bottom.toml;
  };

  # https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=programs.chromium
  # programs.chromium = {
  #   enable = true;
  #   package = pkgs.brave;
  #   commandLineArgs = [ "--enable-devtools-experiments" "" ];
  #   # --file_chooser, --enable-devtools-experiments --enabled-features --disabled-features --flag-switches-begin --flag-switches-end
  #   extensions = [
  #     { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # React devtools
  #     { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
  #     { id = "iohjgamcilhbgmhbnllfolmkmmekfmci"; } # Jam recording
  #     { id = "jnkmfdileelhofjcijamephohjechhna"; } # GA debugger
  #   ];
  # };
}
