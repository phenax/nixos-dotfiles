# https://mozilla.github.io/policy-templates
{ config }: {
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

    DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads/firefox";
    DisableAccounts = true;
    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableProfileImport = true;
    DisableSystemAddonUpdate = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    Homepage = { StartPage = "previous-session"; };
    NewTabPage = false;
    OfferToSaveLogins = false;
    OverrideFirstRunPage = "";
    PasswordManagerEnabled = false;
    DisableSetDesktopBackground = true;
    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
    ShowHomeButton = false;

    # PopupBlocking = [];
    SearchEngines = {
      Default = "DuckDuckGo lite";
      SearchSuggestEnabled = false;
      Remove = [ "Google" "Bing" "Amazon.com" "eBay" "Wikipedia" ];
      PreventInstalls = false;
      Add = [
        {
          Name = "DuckDuckGo lite";
          URLTemplate = "https://duckduckgo.com/lite/?q={searchTerms}";
          Alias = "ddg";
        }
        {
          Name = "DuckDuckGo regular";
          URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
          Alias = "ddgr";
        }
        {
          Name = "Google Sucks";
          URLTemplate = "https://google.com/?q={searchTerms}";
          Alias = "google";
        }
      ];
    };

    Extensions = {
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
  };
}
