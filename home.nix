{ pkgs, ... }:
{
  home.packages = with pkgs; [
    picom
    mtm
  ];

  services.picom = {
    enable = true;
    backend = "glx";
    inactiveOpacity = "0.8";
    inactiveDim = "0.3";
    opacityRule = [
      "98:class_g = 'St' && focused"
      "85:class_g = 'St' && !focused"
      "90:class_g = 'qutebrowser' && !focused"
      "100:class_g = 'qutebrowser' && focused"
    ];
    extraOptions = ''
      focus-exclude = [ "class_g = 'dwm'" "class_g = 'dmenu'"];
    '';
    menuOpacity = "0.9";
  };
}
