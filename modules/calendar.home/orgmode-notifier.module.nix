{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.services.orgmode-notifier;

  service-unit = {
    Service = {
      Type = "oneshot";
      ExecStart = "${config.xdg.configHome}/nvim/orgmode_notifier.sh";
      WorkingDirectory = config.home.homeDirectory;
      Environment = "PATH=${pkgs.neovim}/bin:${pkgs.libnotify}/bin:/usr/bin:/bin";
    };
  };

  timer-unit = {
    Timer = {
      OnCalendar = cfg.pollFrequency;
      RandomizedDelaySec = 30;
    };
    Install.WantedBy = [ "timers.target" ];
  };
in {
  options.services.orgmode-notifier = {
    enable = mkEnableOption "orgmode notifier";
    pollFrequency = mkOption { type = types.str; default = "*:0/1"; };
  };

  config = mkIf cfg.enable {
    programs.lieer.enable = true;
    systemd.user.services.orgmode-notifier = service-unit;
    systemd.user.timers.orgmode-notifier = timer-unit;
  };
}
