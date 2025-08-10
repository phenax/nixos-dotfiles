{ ... }@moduleAttrs:
let
  cfg = import ./config.nix moduleAttrs;
in
{
  services.mpd = {
    enable = true;
    musicDirectory = cfg.mpd.musicDir;
    playlistDirectory = cfg.mpd.playlistDir;
    network = {
      listenAddress = cfg.mpd.host;
      port = cfg.mpd.port;
    };
    extraConfig = ''
      user "imsohexy"
      group "users"
      restore_paused "yes"
      metadata_to_use "artist,album,title,track,name,genre,date,composer,performer,disc"
      auto_update "yes"
      auto_update_depth "5"
      follow_outside_symlinks "yes"
      follow_inside_symlinks "yes"

      input {
        plugin "curl"
      }

      audio_output {
        type "pipewire"
        name "My PipeWire Device"
      }

      audio_output {
        type "fifo"
        name "${cfg.mpd.visualizer_name}"
        path "${cfg.mpd.visualizer_fifo}"
        format "44100:16:2"
      }

      filesystem_charset "UTF-8"
    '';
  };

  services.mpdris2 = {
    # TODO: Hook to update dwmblock
    enable = true;
    notifications = false;
    multimediaKeys = false;
    mpd = {
      host = cfg.mpd.host;
      port = cfg.mpd.port;
      musicDirectory = cfg.mpd.musicDir;
    };
  };
}
