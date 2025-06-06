{ config, ... }:
let
  private = import ./private.nix;
in
{
  imports = [
    ./ical2org.module.nix
    ./orgmode-notifier.module.nix
  ];

  services.ical2org = {
    enable = true;
    icalLink = private.icalLink;
    outputPath = "${config.home.homeDirectory}/nixos/extras/notes/calendar-sync.autogen.org";
    syncFrequency = "*:0/10"; # Every 10 minutes
    settings = {
      filetags = "calendar";
      email = private.email;
      title = "calendar";
      category = "calendar";
      startup = "showeverything";
      past = 6; # days
      future = 30; # days
    };
  };

  services.orgmode-notifier = {
    enable = true;
    pollFrequency = "*:0/1"; # Every minute
  };
}
