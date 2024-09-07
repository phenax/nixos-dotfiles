// ==UserScript==
// @name               DuckduckGo styles
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Github PR helper
// @author             Akshay Nair
// @match              *://*.duckduckgo.com/*
// ==/UserScript==

(() => {
  document.body.classList.add('document-duckduckgo');

  GM_addStyle(`
.document-duckduckgo {
  --ff-accent-color: #8161ff;
  --ff-bg-color: #16121f;
}

.document-duckduckgo {
  background-color: var(--ff-bg-color) !important;
  color: white !important;
  width: 100%;
  margin: auto;
  max-width: 900px !important;
}

.document-duckduckgo a {
  color: var(--ff-accent-color) !important;
}

.document-duckduckgo .result-link {
  font-size: 1rem !important;
}

.document-duckduckgo .did-you-mean {
  font-size: 0.8rem !important;
}
.document-duckduckgo .did-you-mean br {
  display: none !important;
}

.document-duckduckgo select.submit {
  display: none !important;
}

.document-duckduckgo .link-text {
  color: #888 !important;
}

.document-duckduckgo .header {
  font-size: 1rem !important;
}

.document-duckduckgo .result-sponsored {
  display: none !important;
}
`);
})();

