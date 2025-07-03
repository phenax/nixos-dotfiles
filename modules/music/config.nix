{ config, ... } :
{
  # mopidyHttpPort = 6680;
  mpd = {
    host = "127.0.0.1";
    port = 6600;
    musicDir = "${config.home.homeDirectory}/Downloads/music";
    playlistDir = "${config.home.homeDirectory}/Downloads/music/playlist";
    visualizer_name = "my_fifo";
    visualizer_fifo = "/tmp/mpd.fifo";
  };
}
