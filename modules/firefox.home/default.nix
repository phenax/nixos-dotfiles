{ config, pkgs, lib, ... }:
let
  unwrapped-firefox-package = pkgs.firefox-devedition-unwrapped;

  homepage-url = "file://${config.xdg.configHome}/qutebrowser/homepage/index.html";

  extensions = [
    "https://addons.mozilla.org/firefox/downloads/file/3792127/firefox_dracula-1.0.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4261352/tridactyl_vim-1.24.1.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4240798/sidetabs-0.66.xpi"

    # dev
    "https://addons.mozilla.org/firefox/downloads/file/4218479/font_inspect-0.5.8.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4314064/react_devtools-5.3.1.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/3970625/screen_recorder-0.1.8.xpi"

    # others
    "https://addons.mozilla.org/firefox/downloads/file/4332776/languagetool-8.11.6.xpi"
    "https://addons.mozilla.org/firefox/downloads/file/4317971/darkreader-4.9.88.xpi"
  ];

  # about:config
  preferences = {
    "browser.newtabpage.enabled" = false;
    "browser.startup.homepage" = homepage-url;
    "browser.newtab.url" = homepage-url;

    "browser.startup.blankWindow" = false;
    "browser.tabs.drawInTitlebar" = true;
    "browser.uidensity" = 0;
    "browser.theme.dark-private-windows" = true;
    "browser.theme.toolbar-theme" = 0;
    "browser.aboutConfig.showWarning" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    # "devtools.theme" = "dark";
    "ui.systemUsesDarkTheme" = 2;
    # "devtools.toolbox.alwaysOnTop" = true;
    # "devtools.toolbox.host" = "window";
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    # "svg.context-properties.content.enabled" = true;
    "widget.gtk.rounded-bottom-corners.enabled" = true;
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;

    "extensions.pocket.enabled" = false;
    "extensions.pocket.showHome" = false;
    "browser.urlbar.suggest.pocket" = false;
    # "privacy.donottrackheader.enabled" = true;
    "privacy.globalprivacycontrol.enabled" = true;
    "browser.search.suggest.enabled" = false;
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.suggest.recentsearches" = false;
    "browser.sessionstore.restore_tabs_lazily" = false;
    "browser.dataFeatureRecommendations.enabled" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;

    "layout.css.has-selector.enabled" = true; 
    "browser.toolbars.bookmarks.visibility" = "never";
    # "identity.fxaccounts.toolbar.enabled" = false;
    "browser.tabs.insertAfterCurrent" = true;
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.suggest.bookmark" = false;
    "browser.newtab.privateAllowed" = true;

    "browser.download.forbid_open_with" = true;
    "browser.download.autohideButton" = true;
    "browser.download.useDownloadDir" = false;

    # HAcky stuff
    # "general.config.sandbox_enabled" = false;
    # "general.config.obscure_value" = false;
    "xpinstall.signatures.required" = false;
    "extensions.install_origins.enabled" = false;
  };

  # https://mozilla.github.io/policy-templates
  policies = {
    ManagedBookmarks = [
      { toplevel_name = "Managed bookmarks"; }
      { name = "Daily Dev"; url = "https://app.daily.dev"; }
      { name = "Email: Microsoft Outlook"; url = "https://outlook.office365.com/mail/"; }
      { name = "Email: GMail"; url = "https://mail.google.com/mail/u/0/"; }
      # { name = "Shtuff"; children = [] }
    ];
    DisplayBookmarksToolbar = "never";
    NoDefaultBookmarks = true;

    DisableAppUpdate = true;
    DisableSystemAddonUpdate = true;
    DisableProfileImport = true;
    DisableFirefoxStudies = true;
    DisableTelemetry = true;
    DisableFeedbackCommands = true;
    DisablePocket = true;
    DisableAccounts = true;
    DontCheckDefaultBrowser = true;
    OfferToSaveLogins = false;
    PasswordManagerEnabled = false;
    DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads/firefox";
    NewTabPage = false;
    Homepage = { URL = homepage-url; StartPage = "previous-session"; };
    OverrideFirstRunPage = "";

    # PopupBlocking = [];
    SearchEngines = {
      Default = "DuckDuckGo";
      SearchSuggestEnabled = false;
      Remove = [ "Google" "Bing" "Amazon.com" "eBay" "Wikipedia" ];
      PreventInstalls = false;
      Add = [
        {
          Name = "DuckDuckGo";
          URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
          Alias = "ddg";
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

    Extensions = {
      Install = extensions;
      Uninstall = [
        "google@search.mozilla.org"
        "bing@search.mozilla.org"
        "amazondotcom@search.mozilla.org"
        "ebay@search.mozilla.org"
        "wikipedia@search.mozilla.org"
      ];
    };
    ExtensionSettings = {
      "google@search.mozilla.org".installation_mode = "blocked";
      "bing@search.mozilla.org".installation_mode = "blocked";
      "amazondotcom@search.mozilla.org".installation_mode = "blocked";
      "ebay@search.mozilla.org".installation_mode = "blocked";
      "wikipedia@search.mozilla.org".installation_mode = "blocked";
    };

    Preferences = lib.mapAttrs (_key: val: { Status = "locked"; Value = val; }) preferences;
  };

  firefox = pkgs.wrapFirefox unwrapped-firefox-package {
    extraPrefs = builtins.readFile ./autoconfig.js;
  };

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

    ".mozilla/firefox/${profilePath}/chrome".source = ./chrome;

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
