// ==UserScript==
// @name                 Custom New Tab
// @version              1.0
// @description          Load a custom link or local file, instead of the default new tab page (about:newtab).
// ==/UserScript==

// For Firefox 72 onward, see the autoconfig alternative to this:
// https://support.mozilla.org/questions/1251199#answer-1199709

globalThis.newtabLinkStarted = true;

if (!AboutNewTab) {
  globalThis.AboutNewTab = ChromeUtils.import('resource:///modules/AboutNewTab.jsm').AboutNewTab;
}

const newTabUrl = xPref.get('browser.newtab.url') || 'about:blank';

AboutNewTab.newTabURL = newTabUrl;

console.log('Updated new tab url to', newTabUrl);
