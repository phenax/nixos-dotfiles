{ config, pkgs, ... }:
let
  downloadsDir = "/home/imsohexy/Downloads/dl";
  incompleteDownloadsDir = "/home/imsohexy/Downloads/dl/incomplete";
  watchTorrentFilesOn = "/home/an/Downloads/qute";
in {
  services.transmission = {
    enable = true;
    settings = {
      "download-dir" = downloadsDir;
      "download-queue-enabled" = true;
      "download-queue-size" = 5;
      "incomplete-dir" = incompleteDownloadsDir;
      "incomplete-dir-enabled" = true;
      "peer-port" = 51413;
      "peer-port-random-high" = 65535;
      "peer-port-random-low" = 49152;
      "prefetch-enabled" = true;
      "rename-partial-files" = true;
      "rpc-authentication-required" = false;
      "rpc-bind-address" = "127.0.0.1";
      "rpc-enabled" = true;
      "rpc-port" = 9091;
      "rpc-whitelist-enabled" = true;
      "script-torrent-done-enabled" = false;
      "script-torrent-done-filename" = "";
      "start-added-torrents" = true;
      "trash-original-torrent-files" = false;
      "umask" = 18;
      "utp-enabled" = true;
      "watch-dir" = watchTorrentFilesOn;
      "watch-dir-enabled" = false;
    };
  };
}
