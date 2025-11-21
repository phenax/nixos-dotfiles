{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.nessus-agent;
  nessus-agent-fhs = (pkgs.callPackage ./fhs.nix {});
in {
  options.services.nessus-agent = {
    enable = mkEnableOption "nessus agent";
    openFirewall = mkEnableOption "open firewall for nessus";
    port = mkOption { type = types.int; default = 8834; };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d /opt/nessus_agent 0755 root root -"
    ];

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];

    systemd.services.nessus-agent = {
      description = "Tenable Nessus Agent Service";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      path = [ pkgs.coreutils ];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        User = "root";
        Group = "root";
        PIDFile = "/opt/nessus_agent/var/nessus/nessus-service.pid";
        ExecStart = "${nessus-agent-fhs}/bin/nessus-agent-fhs /opt/nessus_agent/sbin/nessus-service -q --port ${toString cfg.port}";
        ExecReload = "/usr/bin/pkill nessusd";
        EnvironmentFile = "-/etc/sysconfig/nessusagent";
        PrivateNetwork = false;
      };
    };
  };
}
