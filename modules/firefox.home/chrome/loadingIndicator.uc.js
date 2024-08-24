// ==UserScript==
// @name                 Loading indicator
// @version              1.0
// @description          Loading indicator for the url bar
// @startup              UC.loadingIndicator.init(win)
// @shutdown             UC.loadingIndicator.destroy()
// ==/UserScript==

(() => {
  const ENABLED = true;

  class TabProgressListener {
    static instances = [];

    static createListener(tab, onStateChange) {
      const oldListener = TabProgressListener.instances.find(l => l.tab === tab)
      if (oldListener) return oldListener;
      const listener = new TabProgressListener(tab, onStateChange);
      TabProgressListener.instances.push(listener);
      listener.attach();
      return listener;
    }

    static cleanup() {
      TabProgressListener.instances.forEach(l => l.cleanup())
    }

    loadedPercentage = 0;
    constructor(tab, onStateChange) {
      this.tab = tab;
      this._stateChange = onStateChange;
    }

    attach() {
      const browser = this.tab.linkedBrowser;
      browser.webProgress.addProgressListener(this, Ci.nsIWebProgress.NOTIFY_ALL)
    }

    cleanup() {
      try {
        const index = TabProgressListener.instances.indexOf(this);
        if (index !== -1)
          TabProgressListener.instances.splice(index, 1);
      } finally {
        this.tab.linkedBrowser.webProgress.removeProgressListener(this);
      }
    }

    // Start query listener methods

    QueryInterface = ChromeUtils.generateQI(['nsIWebProgressListener', 'nsISupportsWeakReference'])

    onStateChange(_webProgress, _request, stateFlags, _status) {
      if (stateFlags & Ci.nsIWebProgressListener.STATE_START) {
        this._stateChange?.('loading');
      } else if (stateFlags & Ci.nsIWebProgressListener.STATE_STOP) {
        this._stateChange?.('loaded');
      }
    }
  }

  const module = {
    onProgressStateUpdate: (win, state) => {
      /** @type {HTMLElement} */
      const urlBar = win.gURLBar.textbox;
      // console.log(state, urlBar);
      if (!urlBar) return;

      // urlBar.style.setProperty('--ff-urlbar-progress', perc);
      urlBar.dataset.pageProgress = state;
    },

    setupTab: (tab, win) => {
      const listener = TabProgressListener.createListener(tab, (state) => module.onProgressStateUpdate(win, state));

      tab.addEventListener('TabClose', () => listener.cleanup());
    },

    setupWindow: win => {
      win.gBrowser.tabs.forEach(tab => module.setupTab(tab, win));
      win.gBrowser.tabContainer.addEventListener('TabOpen', event => {
        module.setupTab(event.target, win);
      });
      win.gBrowser.tabContainer.addEventListener('TabSelect', _event => {
        const isLoading = gBrowser.selectedTab.linkedBrowser.webProgress.isLoadingDocument
        module.onProgressStateUpdate(win, isLoading ? 'loading' : 'loaded');
      });
    },

    init(win) {
      if (!ENABLED) return;

      const handle = () => {
        Services.obs.removeObserver(handle, 'browser-window-before-show');
        module.setupWindow(win);
      }

      if (win.__SSi) handle();
      else Services.obs.addObserver(handle, 'browser-window-before-show');
    },

    destroy() {
      TabProgressListener.cleanup();
    },
  };

  UC.loadingIndicator = module;
})()

