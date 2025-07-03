{ pkgs, lib, ... }:
let
  ntfyCfg = {
    default-host = "http://192.168.0.117:3142";
    subscribe = [
      {
        topic = "media_update";
        command = ''${notify} "$title" "$message"'';
      }
      {
        topic = "ping";
        command = ''${notify} "PING: $title" "$message"'';
      }
      {
        topic = "jellyseer";
        command = ''${notify} "$(echo "$m" | ${jq} -r .title)" "$(echo "$m" | ${jq} -r .body)"'';
      }
      {
        topic = "grafana_alert";
        command = ''${notify} "Grafana alert" "$message"'';
      }
    ];
  };
  sudo = "${pkgs.sudo}/bin/sudo";
  jq = "${pkgs.jq}/bin/jq";
  notify = "${sudo} -u imsohexy ${pkgs.libnotify}/bin/notify-send -a ntfy";
in
{
  environment.systemPackages = with pkgs; [ ntfy-sh ];

  systemd.services.ntfy-client = {
    unitConfig = {
      Description = "ntfy client";
      After = "network.service";
    };

    serviceConfig = let
      ntfyCfgFile = pkgs.writeText "client.yml" (lib.generators.toYAML {} ntfyCfg);
    in {
      ExecStart = "${pkgs.ntfy-sh}/bin/ntfy subscribe --config ${ntfyCfgFile} --from-config";
      Restart = "on-failure";
      Environment = lib.concatStringsSep " " [
        "PATH=${pkgs.dbus}/bin:${pkgs.libnotify}/bin:/bin:/usr/bin"
        "DISPLAY=:0"
      ];
    };

    wantedBy = ["multi-user.target"];
  };
}
