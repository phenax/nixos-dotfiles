{ pkgs, ... }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in {
  #home.packages = with pkgs; [
    #picom
  #];

  services.gpg-agent = {
    enable = true;
    maxCacheTtl = 864000;
    defaultCacheTtl = 864000;
    enableSshSupport = false;
    pinentryFlavor = null;
    extraConfig = ''
      pinentry-program ${localPkgs.anypinentry}/bin/anypinentry
    '';
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
