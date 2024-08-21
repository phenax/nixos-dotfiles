// ==UserScript==
// @name                 Custom New Tab
// @version              1.0
// @description          Load a custom link or local file, instead of the default new tab page
// @startup              UC.customNewTab.updateNewTabURL()
// @shutdown             UC.customNewTab.destroy();
// ==/UserScript==

(() => {
  // Managed in about:config
  const NEWTAB_URL_PREF = 'browser.newtab.url'

  if (!AboutNewTab) {
    globalThis.AboutNewTab = ChromeUtils.import('resource:///modules/AboutNewTab.jsm').AboutNewTab;
  }

  const module = {
    updateNewTabURL: () => {
      const newTabUrl = xPref.get(NEWTAB_URL_PREF) || 'about:blank';
      if (AboutNewTab.newTabURL === newTabUrl) return;

      AboutNewTab.newTabURL = newTabUrl;
      console.log('Updated new tab url to', newTabUrl);
    },

    init() {
      module.updateNewTabURL();
      Services.obs.addObserver(module.updateNewTabURL, 'newtab-url-changed');
    },
    destroy() {
      Services.obs.removeObserver(module.updateNewTabURL, 'newtab-url-changed');
    },
  };

  module.init();

  UC.customNewTab = module;
})();
