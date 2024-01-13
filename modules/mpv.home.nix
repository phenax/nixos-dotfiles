{ config, pkgs, ... }:
{
  programs.mpv = {
    enable = true;

    bindings = {
      "Alt+0" = "set window-scale 0.5";
    };

    config = {
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
      hwdec = "auto-safe";
      vo = "gpu";
      profile = "gpu-hq";
    };

    scripts = [
      pkgs.mpvScripts.uosc
    ];

    # scriptOpts = {
    #   osc = {
    #     scalewindowed = 2.0;
    #     vidscale = false;
    #     visibility = "always";
    #   };
    # };
  };
}
