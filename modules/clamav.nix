{ pkgs, ... }:
let
  enable = true;
in {
  services.clamav = {
    daemon = {
      inherit enable;
    };
    scanner = {
      inherit enable;
      interval = "Sat *-*-* 11:00:00";
      scanDirectories = [
        "/home"
        "/var/lib"
        "/tmp"
        "/etc"
        "/var/tmp"
      ];
    };
    updater = {
      inherit enable;
      frequency = 1;
    };
  };
}
