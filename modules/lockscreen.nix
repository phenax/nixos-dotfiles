{ pkgs, lib, ... }:
let
  localPkgs = import ../packages/default.nix { inherit pkgs; };
in {
  environment.systemPackages = [ localPkgs.bslock ];

  # TODO: Clear gpg pass cache on autolock `gpg-connect-agent reloadagent /bye`
  services.xserver.xautolock = {
    enable = true;
    time = 45; # minutes
    locker = "/run/wrappers/bin/bslock"; # Bslock with security wrapper
    enableNotifier = true;
    notify = 30;
    notifier = ''${pkgs.libnotify}/bin/notify-send "Locking in 30 seconds"'';
    killer = null;
  };

  # Security wrappers
  security.wrappers = {
    bslock = {
      # owner = config.users.users.imsohexy.name;
      owner = "root";
      setuid = true;
      group = "root";
      source = "${localPkgs.bslock}/bin/bslock";
    };
  };
}
