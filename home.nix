{ config, pkgs, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in {
  imports = [
    ./modules/music.nix
    ./overlays-home.nix
  ];

  home.packages = with pkgs; [
    yarn
  ];

  programs.lsd = {
    enable = true;
    enableAliases = true;
  };

  programs.git = {
    enable = true;
    userEmail = "phenax5@gmail.com";
    userName = "Akshay Nair";
    ignores = [
      "tags"
      ".vim.session"
      "tags.lock"
      "tags.temp"
    ];
    aliases = {
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };
    extraConfig = {
      "color" = {
        "ui" = true;
      };
      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };
      "color \"diff\"" = {
        meta = 11;
        frag = "magenta bold";
        commit = "yellow bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
    };
    #signing.key = "GPG-KEY-ID";
    #signing.signByDefault = true;
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
    package = pkgs.pass.withExtensions(exts: [ exts.pass-otp ]);
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

  services.network-manager-applet.enable = true;

  xresources.properties = let
    bg = "#0f0c19";
    fg = "#d8dee9";
    accent = "#4e3aA3";
  in {
    "*.foreground" =   fg;
    "*.background" =   bg;
    "*.cursorColor" =  fg;
    "*.accent" =       accent;

    "*.color0" =  "#15121f";
    "*.color8" =  "#555555";

    "*.color1" =  "#e06c75";
    "*.color9" =  "#bf616a";

    "*.color2" =  "#98C379";
    "*.color10" =  "#a3be8c";

    "*.color3" =  "#E5C07B";
    "*.color11" =  "#f7b731";

    "*.color4" =  "#60a3bc";
    "*.color12" =  "#5e81ac";

    "*.color5" =  "#4e3aA3";
    "*.color13" =  "#4e3aA3";

    "*.color6" =  "#56B6C2";
    "*.color14" =  "#0fb9b1";

    "*.color7" =  "#ABB2BF";
    "*.color15" =  "#ebdbb2";

    "dmenu.background" =     bg;
    "dmenu.foreground" =     fg;
    "dmenu.selbackground" =  accent;
    "dmenu.selforeground" =  fg;

    "dmenu.highlightbg" =    bg;
    "dmenu.highlightfg" =    accent;
    "dmenu.highlightselbg" = accent;
    "dmenu.highlightselfg" = bg;

    "dwm.normbordercolor" =  bg;
    "dwm.normbgcolor" =      bg;
    "dwm.normfgcolor" =      fg;

    "dwm.selbordercolor" =   accent;
    "dwm.selbgcolor" =       accent;
    "dwm.selfgcolor" =       fg;
  };

  home.file = {
    ".config/xorg".source = ./config/xorg;
    ".config/zsh".source = ./config/zsh;
    ".config/nvim".source = ./config/nvim;
    ".config/qutebrowser".source = ./config/qutebrowser;
    ".local/share/qutebrowser/userscripts".source = ./config/qutebrowser/userscripts;
    ".local/share/qutebrowser/greasemonkey".source = ./config/qutebrowser/greasemonkey;
    # ".local/share/qutebrowser/sessions".source = ./private-config/qutebrowser/sessions;
    ".config/dunst".source = ./config/dunst;
    ".config/lf".source = ./config/lf;
    #"Pictures/wallpapers".source = ./extras/wallpapers;
    "scripts".source = ./scripts;
  };

  services.picom = {
    enable = true;
    backend = "glx";
    inactiveDim = "0.3";
    opacityRule = [
      "98:class_g = 'St' && focused"
      "85:class_g = 'St' && !focused"
      "90:class_g = 'qutebrowser' && !focused"
      "100:class_g = 'qutebrowser' && focused"
    ];
    extraOptions = ''
      focus-exclude = [ "class_g = 'dwm'", "class_g = 'dmenu'"];
    '';
    menuOpacity = "0.9";
  };
}
