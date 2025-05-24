{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.mailbox-sync;

  notmuch = "${pkgs.notmuch}/bin/notmuch";
  gmi = "${pkgs.lieer}/bin/gmi";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  jq = "${pkgs.jq}/bin/jq";

  notify-script = ''
    emails=$(${notmuch} search --format=json '${cfg.notify.filter}' \
      | ${jq} -r '.[0:5] | map("* " + .subject + " (tag: " + (.tags | join(" ")) + ")") | join("\n\n")');

    # Notify
    ${notify-send} --app-name=notmuch "New mail baybey ($new_mail_count)" "$emails";
  '';

  sync-script = ''
    #!${pkgs.bash}/bin/bash
    set -eu -o pipefail;

    ${gmi} sync;

    new_mail_count=$(${notmuch} count '${cfg.notify.filter}');
    if [ $new_mail_count = 0 ]; then
      echo "No new mail";
    else
      ${if cfg.notify.enable then notify-script else ""}
    fi

    ${notmuch} tag -new -- tag:new;
  '';

  service-unit = {
    Unit.ConditionPathExists = "${cfg.maildir}/.gmailieer.json";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeScript "mailbox-sync-script" sync-script}";
      WorkingDirectory = cfg.maildir;
      Environment = "NOTMUCH_CONFIG=${config.xdg.configHome}/notmuch/default/config";
    };
  };

  timer-unit = {
    Timer = {
      OnCalendar = cfg.sync.frequency;
      RandomizedDelaySec = 30;
    };
    Install.WantedBy = [ "timers.target" ];
  };
in {
  options.services.mailbox-sync = {
    enable = mkEnableOption "mailbox sync";
    name = mkOption { type = types.str; default = "default"; };
    maildir = mkOption { type = types.str; };
    sync.frequency = mkOption { type = types.str; default = "*:0/5"; };
    notify.enable = mkEnableOption "notify on new mail";
    notify.filter = mkOption {
      type = types.str;
      default = "tag:inbox and tag:unread and tag:new";
    };
  };

  config = mkIf cfg.enable {
    programs.lieer.enable = true;
    systemd.user.services."mailbox-sync-${cfg.name}" = service-unit;
    systemd.user.timers."mailbox-sync-${cfg.name}" = timer-unit;
  };
}
