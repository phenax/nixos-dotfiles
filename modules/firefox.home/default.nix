{ config, pkgs, lib, ... }:
let
  unwrapped-firefox-package = pkgs.firefox-devedition-unwrapped;

  homepage-url = "file://${config.xdg.configHome}/qutebrowser/homepage/index.html";

  extensions = [
    "https://addons.mozilla.org/firefox/downloads/file/3792127/firefox_dracula-1.0.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4261352/tridactyl_vim-1.24.1.xpi"

    # dev
    "https://addons.mozilla.org/firefox/downloads/file/4218479/font_inspect-0.5.8.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4314064/react_devtools-5.3.1.xpi"

    # content
    "https://addons.mozilla.org/firefox/downloads/file/4332776/languagetool-8.11.6.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4317971/darkreader-4.9.88.xpi"
  ];

  # about:config
  preferences = {
    "browser.newtabpage.enabled" = false;
    "browser.startup.homepage" = homepage-url;

    "browser.startup.blankWindow" = false;
    "browser.tabs.drawInTitlebar" = true;
    "browser.uidensity" = 0;
    "browser.theme.dark-private-windows" = true;
    "browser.theme.toolbar-theme" = 0;
    "browser.aboutConfig.showWarning" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "devtools.theme" = "dark";
    "devtools.toolbox.alwaysOnTop" = true;
    "devtools.toolbox.host" = "window";
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    "svg.context-properties.content.enabled" = true;

    "extensions.pocket.enabled" = false;
    "extensions.pocket.showHome" = false;
    "browser.urlbar.suggest.pocket" = false;
    "privacy.donottrackheader.enabled" = true;
    "privacy.globalprivacycontrol.enabled" = true;
    "browser.search.suggest.enabled" = false;
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.suggest.recentsearches" = false;
    "browser.sessionstore.restore_tabs_lazily" = false;
    "browser.dataFeatureRecommendations.enabled" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;

    "browser.toolbars.bookmarks.visibility" = "never";
    "identity.fxaccounts.toolbar.enabled" = false;
    "browser.tabs.insertAfterCurrent" = true;
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.suggest.bookmark" = false;
  };

  # https://mozilla.github.io/policy-templates
  policies = {
    ManagedBookmarks = [
      { toplevel_name = "Managed bookmarks"; }
      { name = "Daily Dev"; url = "https://app.daily.dev"; }
      # { name = "Shtuff"; children = [] }
    ];
    DisplayBookmarksToolbar = "never";
    NoDefaultBookmarks = true;

    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DisableAccounts = true;
    DontCheckDefaultBrowser = true;
    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;
    DefaultDownloadDirectory = "\${home}/Downloads/firefox";
    NewTabPage = false;
    Homepage = { URL = homepage-url; StartPage = "previous-session"; };

    # PopupBlocking = [];
    SearchEngines = {
      Default = "DuckDuckGo";
      SearchSuggestEnabled = false;
      Add = [
        {
          Name = "DuckDuckGo";
          URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
          Alias = "google";
        }
        {
          Name = "Google";
          URLTemplate = "https://google.com/?q={searchTerms}";
          Alias = "google";
        }
      ];
    };

    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };

    ShowHomeButton = false;

    # Permissions = {
    #   Camera = {
    #     Allow = [ "https://meet.google.com" ];
    #     Block = [];
    #   };
    # };

    Extensions = { Install = extensions; };

    Preferences = lib.mapAttrs (_key: val: { Status = "locked"; Value = val; }) preferences;
  };

  firefox = pkgs.wrapFirefox unwrapped-firefox-package {};

  profilePath = "default";
in {
  programs.firefox = {
    enable = true;
    package = firefox;

    nativeMessagingHosts = [ pkgs.tridactyl-native ];

    policies = policies;
  };

  home.file = {
    ".config/tridactyl".source = ./tridactyl;

    ".mozilla/firefox/${profilePath}/chrome/userChrome.css".text = builtins.readFile ./userChrome.css;

    ".mozilla/firefox/profiles.ini".text = lib.generators.toINI {} {
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
  };
}
