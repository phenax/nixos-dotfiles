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
      save-position-on-quit = true;
    };

    scripts = with pkgs.mpvScripts; [
      uosc
      videoclip # c to clip
      youtube-upnext # <c-u> to show menu
      mpv-cheatsheet # ? to see hints
      # webtorrent-mpv-hook
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
