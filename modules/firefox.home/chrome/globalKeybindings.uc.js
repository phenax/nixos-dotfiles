// ==UserScript==
// @name                 Global Keybindings
// @version              1.0
// @description          Setup global keybindings on all windows
// @startup              UC.globalKeybindings.init(win);
// @shutdown             UC.globalKeybindings.destroy();
// ==/UserScript==

(() => {
  // Configure global keybindings
  const KEYBINDINGS = () => ({
    RELEASE: [
      [ctrl(shift(key('J'))), moveSelectedTabBy(+1)],
      [ctrl(shift(key('K'))), moveSelectedTabBy(-1)],
      [ctrl(shift(key('B'))), sidetabs.toggle],
      [ctrl(alt(key('p'))), togglePassthrough, { modes: ALL_MODES }],
      [alt(key('h')), history.back],
      [alt(key('l')), history.forward],
    ],
    PRESS: [
      // Block default key bindings
      [ctrl(shift(key('J'))), preventDefault()],
      [ctrl(shift(key('K'))), preventDefault()],
      [ctrl(shift(key('B'))), preventDefault()],
      [ctrl(key('h')), preventDefault()],
      [ctrl(key('b')), preventDefault()],
      [alt(key('h')), preventDefault()],
      [alt(key('l')), preventDefault()],

      [ctrl(key('j')), preventDefault(nextTab())],
      [ctrl(key('k')), preventDefault(prevTab())],

      // Ctrl + number takes to the tab at position
      ...(Array.from({ length: 10 }, (_, idx) =>
        [ctrl(key(idx === 9 ? 0 : idx + 1)), tabIndex(idx)],
      )),
    ],
  });

  // Restart firefox: Services.startup.quit(Services.startup.eForceQuit | Services.startup.eRestart)

  const nextTab = () => () => updateTabIndex((n, len) => (n + 1) % len);
  const prevTab = () => () => updateTabIndex((n, len) => n === 0 ? len - 1 : n - 1);
  const tabIndex = idx => () => updateTabIndex((_n, _len) => idx)
  const preventDefault = f => e => { e.preventDefault(); f?.(e); };
  const moveSelectedTabBy = incr => () => updateSelectedTabIndex(incr);
  const togglePassthrough = () => UC.globalKeybindings.updateMode(m => m !== MODE_PASSTHRU ? MODE_PASSTHRU : MODE_NORMAL)

  const history = {
    back: () => gBrowser.goBack(),
    forward: () => gBrowser.goForward(),
  }

  const sidetabs = {
    // getExtensionId: () => {
    //   return [...SidebarController.sidebars].find(([_, p]) => p.label?.match(/sidetabs/i))?.[0];
    // },
    ensureReady: async () => {
      // Hide sidebar
      SidebarController.hide();
      // Close by default
      SidebarController.toggleExpanded(false);
      // for (let i = 0; i < 3; i++) {
      //   if (sidetabs.getExtensionId()) {
      //     return !SidebarController.isOpen && SidebarController.show(sidetabs.getExtensionId() ?? undefined)
      //   } else {
      //     console.log('sidebar retry...');
      //     await new Promise(res => setTimeout(res), 100);
      //   }
      // }
    },
    toggle: async () => {
      SidebarController.toggleExpanded();
      // await sidetabs.ensureReady();
      // const sidebar = document.getElementById('sidebar-box');
      // sidebar?.classList.toggle('open');
    },
  }

  const MODE_PASSTHRU = 'passthru';
  const MODE_NORMAL = '';
  const ALL_MODES = [MODE_NORMAL, MODE_PASSTHRU];

  const ctrl = b => e => b(e) && e.ctrlKey;
  const alt = b => e => b(e) && e.altKey;
  const shift = b => e => b(e) && e.shiftKey;
  const key = key => e => `${e.key}` === `${key}`;

  const updateTabIndex = (f) => {
    const newIndex = f(gBrowser.tabContainer.selectedIndex, gBrowser.tabs.length)
    if (typeof newIndex !== 'number') return;
    if (newIndex >= gBrowser.tabContainer.allTabs.length) return;
    if (newIndex < 0) return;
    gBrowser.selectTabAtIndex(newIndex);
  };

  const updateSelectedTabIndex = (incr) => {
    if (typeof incr !== 'number') return;
    if (incr === +1) return gBrowser.moveTabForward();
    if (incr === -1) return gBrowser.moveTabBackward();
    const newIndex = gBrowser.tabContainer.selectedIndex + incr;
    if (newIndex >= gBrowser.tabContainer.allTabs.length) return;
    if (newIndex < 0) return;
    gBrowser.moveTabTo(gBrowser.selectedTab, newIndex)
  };

  const module = {
    mode: MODE_NORMAL,
    allModes: ALL_MODES,

    keybindings: KEYBINDINGS(),

    evaluateKeybindings: (bindings, e) => {
      for (const [isKey, action, options] of bindings) {
        // Only allow keys from the given mode
        if ((options?.modes ?? [MODE_NORMAL]).includes(module.mode)) {
          if (isKey(e)) {
            const shouldContinue = action(e);
            if (!shouldContinue) break;
          }
        }
      }
    },

    updateMode: f => {
      module.mode = f(module.mode);
      if (gNavToolbox) gNavToolbox.dataset.keyMode = module.mode;
      Services.obs.notifyObservers(null, 'uc:globalKeybindings:modeChanged', module.mode);
    },

    handleKeyUpEvent: e => module.evaluateKeybindings(module.keybindings.RELEASE, e),
    handleKeyDownEvent: e => module.evaluateKeybindings(module.keybindings.PRESS, e),

    onWindowReady: async (win) => {
      win.addEventListener('keyup', module.handleKeyUpEvent, true);
      win.addEventListener('keydown', module.handleKeyDownEvent, true);

      await sidetabs.ensureReady();
    },

    init(win) {
      const observe = () => {
        Services.obs.removeObserver(observe, 'browser-window-before-show');
        module.onWindowReady(win)
      }

      if (win.__SSi) {
        module.onWindowReady(win)
      } else {
        Services.obs.addObserver(observe, 'browser-window-before-show');
      }
    },
    destroy() {
      _uc.windows((_doc, win) => {
        win.removeEventListener('keyup', module.handleKeyUpEvent, true);
        win.removeEventListener('keydown', module.handleKeyDownEvent, true);
      });
      delete UC.globalKeybindings;
    },
  };

  UC.globalKeybindings = module;
})();
