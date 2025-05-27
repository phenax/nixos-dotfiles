{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.ical2org;

  bunx = "${pkgs.bun}/bin/bunx";
  curl = "${pkgs.curl}/bin/curl";
  mktemp = "${pkgs.coreutils-full}/bin/mktemp";
  rm = "${pkgs.coreutils-full}/bin/rm";

  config-file =
    pkgs.writeText "icsorg-config" (concatStringsSep "\n"
      (mapAttrsToList (key: val: "${strings.toUpper key}=${toString val}") cfg.settings));

  sync-script = ''
    #!${pkgs.bash}/bin/bash
    set -eu -o pipefail;

    file=$(${mktemp} /tmp/ical2org.XXXX.ical);
    trap "${rm} -f '$file'" EXIT;

    ${curl} "${cfg.icalLink}" -o "$file";
    ${bunx} icsorg -c "${config-file}" -i "$file" -o "${cfg.outputPath}";
  '';

  service-unit = {
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeScript "ical2org" sync-script}";
      WorkingDirectory = config.home.homeDirectory;
    };
  };

  timer-unit = {
    Timer = {
      OnCalendar = cfg.syncFrequency;
      RandomizedDelaySec = 30;
    };
    Install.WantedBy = [ "timers.target" ];
  };
in {
  options.services.ical2org = {
    enable = mkEnableOption "ical2org sync";
    syncFrequency = mkOption { type = types.str; default = "*:0/30"; };
    icalLink = mkOption { type = types.str; };
    outputPath = mkOption { type = types.str; };
    settings = mkOption { type = types.attrs; default = {}; };
  };

  config = mkIf cfg.enable {
    programs.lieer.enable = true;
    systemd.user.services.ical2org = service-unit;
    systemd.user.timers.ical2org = timer-unit;
  };
}
