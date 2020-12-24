{ pkgs, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in {
  imports = [ ./overlays-home.nix ];

  home.packages = with pkgs; [
    yarn
    #pass
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

  home.file = {
    ".config/zsh".source = ./config/zsh;
    ".config/nvim".source = ./config/nvim;
    ".config/qutebrowser".source = ./config/qutebrowser;
    ".local/share/qutebrowser/userscripts".source = ./config/qutebrowser/userscripts;
    ".local/share/qutebrowser/greasemonkey".source = ./config/qutebrowser/greasemonkey;
    # ".local/share/qutebrowser/sessions".source = ./private-config/qutebrowser/sessions;
    ".config/dunst".source = ./config/dunst;
    ".config/lf".source = ./config/lf;
    "Pictures/wallpapers".source = ./extras/wallpapers;
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
