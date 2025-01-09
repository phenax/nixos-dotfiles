{ pkgs, ... }: {
  services.clamav = {
    daemon.enable = true;
    scanner = {
      enable = true;
      interval = "Sun *-*-* 12:00:00";
      # scanDirectories = [
      #   "/home"
      #   "/var/lib"
      #   "/tmp"
      #   "/etc"
      #   "/var/tmp"
      # ];
    };
    updater.enable = false;
  };
}
