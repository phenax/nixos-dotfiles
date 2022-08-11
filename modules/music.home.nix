{ config, pkgs, ... }:
let
  visualizer_name = "my_fifo";
  visualizer_fifo = "/tmp/mpd.fifo";
  mpd = {
    host = "127.0.0.1";
    port = 6600;
    musicDir = "${config.home.homeDirectory}/Downloads/music";
    playlistDir = "${config.home.homeDirectory}/Downloads/music/playlist";
  };
in
{
  home.packages = with pkgs; [ mpc_cli playerctl ];

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };

    settings = {
      user_interface = "alternative";
      playlist_display_mode = "columns";
      browser_display_mode = "columns";
      playlist_editor_display_mode = "classic";

      empty_tag_color = "magenta";
      header_window_color = "magenta";
      volume_color = "cyan";
      state_line_color = "magenta";
      state_flags_color = "magenta:b";
      color1 = "white";
      color2 = "magenta";
      main_window_color = "white";
      progressbar_color = "black:b";
      progressbar_elapsed_color = "magenta:b";
      statusbar_color = "magenta";
      statusbar_time_color = "magenta:b";
      player_state_color = "magenta:b";
      alternative_ui_separator_color = "magenta";
      window_border_color = "magenta";
      active_window_border = "red";

      progressbar_look = "=>-";
      now_playing_prefix = "$(blue)$b";
      now_playing_suffix = "$/b$(end)";
      current_item_prefix = "$(magenta)$r$b";
      current_item_suffix = "$/r$(end)$/b";
      current_item_inactive_column_prefix = "$(white)$r";
      current_item_inactive_column_suffix = "$/r$(end)";

      media_library_primary_tag = "album_artist";
      media_library_albums_split_by_date = "no";
      startup_screen = "browser";
      ignore_leading_the = "yes";
      display_volume_level = "no";
      external_editor = "sensible-editor";
      use_console_editor = "yes";
      mouse_support = "yes";

      visualizer_data_source = visualizer_fifo;
      visualizer_output_name = visualizer_name;
      visualizer_type = "spectrum";
      visualizer_in_stereo = "yes";
      visualizer_look = "●●";
      visualizer_color = "white, cyan, blue, magenta, red, red, black";
      visualizer_spectrum_smooth_look = "yes";
      visualizer_autoscale = "yes";
      visualizer_spectrum_dft_size = 3;
    };

    bindings = with builtins; let
      toBinding = s: let get = elemAt s; in { key = get 0; command = get 1; };
    in
    map toBinding [
      [ "h" [ "previous_column" "master_screen" "jump_to_parent_directory" ] ]
      [ "l" [ "next_column" "slave_screen" "enter_directory" ] ]
      [ "k" "scroll_up" ]
      [ "j" "scroll_down" ]
      [ "g" "page_up" ]
      [ "G" "page_down" ]
      [ "d" "delete_playlist_items" ]
      [ "n" "next_found_item" ]
      [ "N" "previous_found_item" ]
      [ "P" "show_playlist_editor" ]
      [ "B" "show_browser" ]
      [ "s" "show_search_engine" ]
      [ "S" "show_search_engine" ]
      [ "8" "show_visualizer" ]
      [ "ctrl-s" "save_playlist" ]
      [ "c" "clear_main_playlist" ]
      [ "ctrl-l" "show_lyrics" ]
    ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = mpd.musicDir;
    playlistDirectory = mpd.playlistDir;
    network = {
      listenAddress = mpd.host;
      port = mpd.port;
    };
    extraConfig = ''
      user "imsohexy"
      group "users"
      restore_paused "yes"
      metadata_to_use	"artist,album,title,track,name,genre,date,composer,performer,disc"
      auto_update	"yes"
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
        name "${visualizer_name}"
        path "${visualizer_fifo}"
        format "44100:16:2"
      }

      filesystem_charset		"UTF-8"
    '';
  };

  services.mpdris2 = {
    enable = true;
    notifications = false;
    multimediaKeys = false;
    mpd = {
      host = mpd.host;
      port = mpd.port;
      musicDirectory = mpd.musicDir;
    };
  };
}
