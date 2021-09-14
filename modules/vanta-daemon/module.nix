{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.vanta;
in
{
  options.services.vanta = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = '' Vanta daemon service  '';
    };

    agentKey = mkOption {
      type = types.str;
    };

    email = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable (
    let
      vanta = pkgs.callPackage ./default.nix {};
    in
      {
        environment.systemPackages = [ vanta ];

        systemd.services.vanta =
          {
            after = [ "network.service" "syslog.service" ];
            description = "Vanta monitoring software";
            wantedBy = [ "multi-user.target" ];
            preStart = ''
              cp -a ${vanta}/var/vanta /var
              sed \
                -e 's/\("AGENT_KEY": "\)"/\1${cfg.agentKey}"/1' \
                -e 's/\("OWNER_EMAIL": "\)"/\1${cfg.email}"/' \
                ${vanta}/etc/vanta.conf > /etc/vanta.conf
            '';
            script = ''
              /var/vanta/metalauncher
            '';

            serviceConfig = {
              TimeoutStartSec = 0;
              Restart = "on-failure";
              KillMode = "control-group";
              KillSignal = "SIGTERM";
            };
          };
      }
  );
}
