// ==UserScript==
// @name                 Custom New Tab
// @version              1.0
// @description          Load a custom link or local file, instead of the default new tab page
// @startup              UC.extensionsManager.init(win)
// @shutdown             UC.extensionsManager.destroy();
// ==/UserScript==

(() => {
  const ENABLE = false;

  // Managed in about:config
  const EXTENSION_SETTINGS_PREF = 'extensions.uc.userExtensionSettings'

  const getSettings = () => {
    try {
      return JSON.parse(xPref.get(EXTENSION_SETTINGS_PREF) || 'null') ?? {};
    } catch (e) {
      return {};
    }
  }

  const saveSettings = (settings) =>
    xPref.set(EXTENSION_SETTINGS_PREF, JSON.stringify(settings));

  const updateExtensionSetting = (id, update) => {
    const settings = getSettings();
    settings.extensions[id] ??= {};
    settings.extensions[id] = update(settings.extensions[id] ?? {}) ?? {};
    saveSettings(settings);
  }

  const getCurrentTabHost = () => gBrowser.selectedTab.linkedBrowser.currentURI.host.trim() || null;

  const module = {
    disableForHost(id, host = getCurrentTabHost()) {
      updateExtensionSetting(id, s => {
        const urls = new Set(s.disabledHosts || []);
        urls.add(host);
        s.disabledHosts = [...urls];
        return s;
      });
    },

    async onTabChange() {
      const currentHost = getCurrentTabHost();
      if (!currentHost) return;

      const settings = getSettings();
      const addons = await AddonManager.getAllAddons();
      addons.forEach(addon => {
        const disabledHosts = settings?.extensions[addon.id].disabledHosts ?? [];
        const shouldDisable = disabledHosts.includes(currentHost)

        if (addon.isActive && shouldDisable)
          return addon.disable();
        if (!addon.isActive && !shouldDisable)
          return addon.enable();
      })
    },

    init(_win) {
      if (!ENABLE) return;

      Services.obs.addObserver(module.onTabChange, 'TabSelect');
    },
    destroy() {
      Services.obs.removeObserver(module.onTabChange, 'TabSelect');
    },
  };

  UC.extensionsManager = module;
})();
