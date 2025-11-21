{ pkgs, ... }:
let
  downloadsDir = "/home/imsohexy/Downloads/_downloads";
  incompleteDownloadsDir = "${downloadsDir}/_incomplete";

  group = "multimedia";
in
{
  systemd.tmpfiles.rules = [
    "d ${downloadsDir} 0770 - ${group} - -"
    "d ${incompleteDownloadsDir} 0770 - ${group} - -"
  ];
  users.groups."${group}" = { };
  users.users.imsohexy.extraGroups = [ group ];

  services.transmission = {
    enable = true;
    group = group;
    package = pkgs.transmission_4;
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
      "start-added-torrents" = true;
      "trash-original-torrent-files" = false;
      "umask" = 18;
      "utp-enabled" = true;
      "watch-dir-enabled" = false;
    };
  };
}
