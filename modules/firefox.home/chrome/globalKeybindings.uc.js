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
      [ctrl(key('j')), nextTab()],
      [ctrl(key('k')), prevTab()],
      [alt(key('j')), moveSelectedTabBy(+1)],
      [alt(key('k')), moveSelectedTabBy(-1)],
      [ctrl(shift(key('J'))), moveSelectedTabBy(+1)],
      [ctrl(shift(key('K'))), moveSelectedTabBy(-1)],

      ...(Array.from({ length: 10 }, (_, idx) =>
        [ctrl(key(idx === 9 ? 0 : idx + 1)), tabIndex(idx)],
      )),
    ],
    PRESS: [
      // Prevent the default browser's action
      [ctrl(shift(key('J'))), preventDefault()],
      [ctrl(shift(key('K'))), preventDefault()],
    ],
  });

  const nextTab = () => () => updateTabIndex((n, len) => (n + 1) % len);
  const prevTab = () => () => updateTabIndex((n, len) => n === 0 ? len - 1 : n - 1);
  const tabIndex = idx => () => updateTabIndex((_n, _len) => idx)
  const preventDefault = f => e => { e.preventDefault(); f?.(e); };
  const moveSelectedTabBy = incr => () => updateSelectedTabIndex(incr);

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
    enabled: true,

    evaluateKeybindings: (bindings, e) => {
      if (!module.enabled) return;

      for (const [isKey, action] of bindings) {
        if (isKey(e)) {
          const shouldContinue = action(e);
          if (!shouldContinue) break;
        }
      }
    },

    handleKeyUpEvent: e => module.evaluateKeybindings(KEYBINDINGS().RELEASE, e),
    handleKeyDownEvent: e => module.evaluateKeybindings(KEYBINDINGS().PRESS, e),

    init(win) {
      let observe = () => {
        Services.obs.removeObserver(observe, 'browser-window-before-show');
        win.addEventListener('keyup', module.handleKeyUpEvent, true);
        win.addEventListener('keydown', module.handleKeyDownEvent, true);
      }

      if (win.__SSi) {
        win.addEventListener('keyup', module.handleKeyUpEvent, true);
        win.addEventListener('keydown', module.handleKeyDownEvent, true);
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
