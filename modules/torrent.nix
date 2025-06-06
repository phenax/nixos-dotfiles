{ pkgs, ... }:
let
  downloadsDir = "/home/imsohexy/Downloads/dl";
  incompleteDownloadsDir = "${downloadsDir}/incomplete";
  watchTorrentFilesOn = "/home/imsohexy/Downloads/qute";

  radarrPort = 7878;
  sonarrPort = 8989;
  prowlarrPort = 9696;

  group = "multimedia";
in
{
  systemd.tmpfiles.rules = [
    "d ${downloadsDir} 0770 - ${group} - -"
  ];
  users.groups."${group}" = { };
  users.users.imsohexy.extraGroups = [ group ];

  environment.systemPackages = with pkgs; [ managarr ];

  services.service-router.routes = {
    sonarr.port = sonarrPort;
    radarr.port = radarrPort;
    prowlarr.port = prowlarrPort;
  };

  services.transmission = {
    enable = true;
    group = group;
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
      "watch-dir" = watchTorrentFilesOn;
      "watch-dir-enabled" = false;
    };
  };

  services.sonarr = {
    enable = true;
    # openFirewall = true;
    user = "imsohexy";
    group = group;
    settings = {
      server.port = sonarrPort;
      auth.enabled = false;
    };
  };

  services.radarr = {
    enable = true;
    # openFirewall = true;
    user = "imsohexy";
    group = group;
    settings = {
      server.port = radarrPort;
      auth.enabled = false;
    };
  };

  services.prowlarr = {
    enable = true;
    # openFirewall = true;
    settings = {
      server.port = prowlarrPort;
    };
  };
}
