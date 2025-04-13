{ config, pkgs, lib, ... }:
let
  unwrappedFirefoxPackage = pkgs.firefox-devedition-unwrapped;

  firefoxBinName = "firefox-devedition";

  configDir = ".mozilla/firefox";

  extensions = [
    "https://addons.mozilla.org/firefox/downloads/file/3792127/firefox_dracula-1.0.xpi"
    # "https://addons.mozilla.org/firefox/downloads/file/4261352/tridactyl_vim-1.24.1.xpi"
    # "https://addons.mozilla.org/firefox/downloads/file/4240798/sidetabs-0.66.xpi"
    "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"

    # dev
    "https://addons.mozilla.org/firefox/downloads/file/4218479/font_inspect-0.5.8.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4314064/react_devtools-5.3.1.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/3970625/screen_recorder-0.1.8.xpi"

    # others
    "https://addons.mozilla.org/firefox/downloads/file/4332776/languagetool-8.11.6.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4317971/darkreader-4.9.88.xpi"
  ];

  preferences = (import ./preferences.nix { inherit config; });

  policies = lib.recursiveUpdate (import ./policies.nix { inherit config; }).policies {
    Extensions.Install = extensions;
    Preferences = lib.mapAttrs (_key: val: { Status = "locked"; Value = val; }) preferences;
  };

  firefox = pkgs.wrapFirefox unwrappedFirefoxPackage {
    extraPrefs = builtins.readFile ./autoconfig.js;
  };

  profilePath = "default";
in {
  programs.firefox = {
    enable = false;
    package = firefox;

    # nativeMessagingHosts = [ pkgs.tridactyl-native ];
    policies = policies;
  };

  home.packages = if config.programs.firefox.enable then [
    (pkgs.writeShellScriptBin "firefox" ''exec ${firefox}/bin/${firefoxBinName}'')
  ] else [];

  home.file = if config.programs.firefox.enable then {
    # ".config/tridactyl".source = ./tridactyl;

    "${configDir}/${profilePath}/chrome".source = ./chrome;

    "${configDir}/profiles.ini".text = lib.generators.toINI {} {
      Profile1 = {
        Name = "default";
        IsRelative = 1;
        Path = profilePath;
      };
      Profile0 = {
        Name = "dev-edition-default";
        Default = 1;
        IsRelative = 1;
        Path = profilePath;
      };
      General = {
        StartWithLastProfile = 1;
        Version = 2;
      };
    };
  } else {};
}
