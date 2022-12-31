{ config, pkgs, epkgs, ... }:
{
  xresources.properties =
    let
      theme = import ./xresources/catcula.nix;
      # theme = import ./xresources/tealicious.nix;
    in
    {
      "*.foreground" = theme.foreground;
      "*.background" = theme.background;
      "*.cursorColor" = theme.foreground;
      "*.accent" = theme.accent;

      "*.color0" = "#15121f";
      "*.color8" = "#555555";

      "*.color1" = "#e06c75";
      "*.color9" = "#7c162e";

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

      "dmenu.background" = theme.background;
      "dmenu.foreground" = theme.foreground;
      "dmenu.selbackground" = theme.accent;
      "dmenu.selforeground" = theme.foreground;

      "dmenu.highlightbg" = theme.background;
      "dmenu.highlightfg" = theme.accent;
      "dmenu.highlightselbg" = theme.accent;
      "dmenu.highlightselfg" = theme.background;

      "dwm.normbordercolor" = theme.background;
      "dwm.normbgcolor" = theme.background;
      "dwm.normfgcolor" = theme.foreground;

      "dwm.selbordercolor" = theme.accent;
      "dwm.selbgcolor" = theme.accent;
      "dwm.selfgcolor" = theme.foreground;
    };
}
