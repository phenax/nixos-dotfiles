{ config, pkgs, epkgs, ... }:
{
  xresources.properties = let
    bg = "#0f0c19";
    fg = "#d8dee9";
    accent = "#4e3aA3";
    ##A22F3E
    ##A1313F
    ##A82E3D
    ##AE2E3D
    ##EB4960
    ##B22337
    ##F32929
  in
    {
      "*.foreground" = fg;
      "*.background" = bg;
      "*.cursorColor" = fg;
      "*.accent" = accent;

      "*.color0" = "#15121f";
      "*.color8" = "#555555";

      "*.color1" = "#e06c75";
      "*.color9" = "#bf616a";

      "*.color2" = "#98C379";
      "*.color10" = "#a3be8c";

      "*.color3" = "#E5C07B";
      "*.color11" = "#f7b731";

      "*.color4" = "#60a3bc";
      "*.color12" = "#5e81ac";

      "*.color5" = "#4e3aA3";
      "*.color13" = "#4e3aA3";

      "*.color6" = "#56B6C2";
      "*.color14" = "#0fb9b1";

      "*.color7" = "#ABB2BF";
      "*.color15" = "#ebdbb2";

      "dmenu.background" = bg;
      "dmenu.foreground" = fg;
      "dmenu.selbackground" = accent;
      "dmenu.selforeground" = fg;

      "dmenu.highlightbg" = bg;
      "dmenu.highlightfg" = accent;
      "dmenu.highlightselbg" = accent;
      "dmenu.highlightselfg" = bg;

      "dwm.normbordercolor" = bg;
      "dwm.normbgcolor" = bg;
      "dwm.normfgcolor" = fg;

      "dwm.selbordercolor" = accent;
      "dwm.selbgcolor" = accent;
      "dwm.selfgcolor" = fg;
    };
}
