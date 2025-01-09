{ config, pkgs, lib, ... }:
let
  thunderbird = pkgs.thunderbird-latest;

  extensions = [
    # Theme
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/dracula-theme-for-thunderbird/addon-987962-latest.xpi"
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/luminous-matter/addon-988120-latest.xpi"
    "https://addons.thunderbird.net/thunderbird/downloads/latest/dark-black-theme/addon-988343-latest.xpi"

    "https://addons.thunderbird.net/thunderbird/downloads/latest/grammar-and-spell-checker/addon-988138-latest.xpi"
    # "https://addons.thunderbird.net/thunderbird/downloads/latest/external-editor-revived/addon-988342-latest.xpi"
  ];

  policies = {
    Extensions.Install = extensions;
  };

  preferences = {
    # "general.useragent.override" = "";
    # "mail.spellcheck.inline" = true;
    "privacy.donottrackheader.enabled" = true;
  };
in {
  programs.thunderbird = {
    enable = true;
    package = thunderbird;
    policies = policies;
    preferencesStatus = "default";
    preferences = preferences;
  };
}
