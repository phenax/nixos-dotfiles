{ pkgs }:
let
  localPkgs = import ./packages/default.nix { pkgs = pkgs; };
in {
  environment.systemPackages = [ localPkgs.bslock ];

  services.xserver.xautolock = rec {
    enable = true;
    time = 15; # minutes
    locker = "${localPkgs.bslock}/bin/bslock";

    enableNotifier = true;
    notify = 30;
    notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in ${notify} seconds'";
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