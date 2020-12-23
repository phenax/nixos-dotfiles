{ pkgs, ... }:
{
  #home.packages = with pkgs; [
    #picom
  #];

  services.gpg-agent = {
    enable = true;
    maxCacheTtl = 864000;
    defaultCacheTtl = 864000;
    enableSshSupport = false;
  };

  home.file = {
    ".config/dunst".source = ./config/dunst;
    ".config/lf".source = ./config/lf;
    ".config/qutebrowser".source = ./config/qutebrowser;
    ".local/share/qutebrowser/userscripts".source = ./config/qutebrowser/userscripts;
    ".local/share/qutebrowser/greasemonkey".source = ./config/qutebrowser/greasemonkey;
    # ".local/share/qutebrowser/sessions".source = ./private-config/qutebrowser/sessions;
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
