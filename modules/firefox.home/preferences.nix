# about:config
{ config }:
let
  homepage-url = "file://${config.xdg.configHome}/qutebrowser/homepage/index.html";
in {
    "browser.newtabpage.enabled" = false;
    "browser.startup.homepage" = homepage-url;
    "browser.newtab.url" = homepage-url;
    "browser.ml.chat.enabled" = false;

    "sidebar.verticalTabs" = true;
    "sidebar.main.tools" = "";
    "sidebar.visibility" = "always-show";
    "browser.startup.blankWindow" = false;
    "browser.tabs.drawInTitlebar" = true;
    "browser.uidensity" = 0;
    "browser.theme.dark-private-windows" = true;
    "browser.theme.toolbar-theme" = 0;
    "browser.aboutConfig.showWarning" = false;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "ui.systemUsesDarkTheme" = 2;
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;
    "widget.gtk.rounded-bottom-corners.enabled" = true;
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;
    "dom.security.https_first" = true;

    "extensions.pocket.enabled" = false;
    "extensions.pocket.showHome" = false;
    "browser.urlbar.suggest.pocket" = false;
    "privacy.globalprivacycontrol.enabled" = true;
    "browser.search.suggest.enabled" = false;
    "browser.urlbar.suggest.searches" = false;
    "browser.urlbar.suggest.recentsearches" = false;
    "browser.sessionstore.restore_tabs_lazily" = false;
    "browser.dataFeatureRecommendations.enabled" = false;
    "extensions.htmlaboutaddons.recommendations.enabled" = false;

    "layout.css.has-selector.enabled" = true; 
    "browser.toolbars.bookmarks.visibility" = "never";
    "browser.tabs.insertAfterCurrent" = true;
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.suggest.bookmark" = false;
    "browser.newtab.privateAllowed" = true;

    "browser.download.forbid_open_with" = true;
    "browser.download.autohideButton" = true;
    "browser.download.useDownloadDir" = false;

    # HAcky stuff
    "xpinstall.signatures.required" = false;
    "extensions.install_origins.enabled" = false;
  }
