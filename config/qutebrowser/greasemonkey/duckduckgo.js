// ==UserScript==
// @name               Github PR helper
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Github PR helper
// @author             Akshay Nair
// @match              *://duckduckgo.com/*
// ==/UserScript==

(() => {
  const load = str =>
    str.split(' ').forEach(x => (document.cookie = x));

  load('ae=d; 5=2; s=m; p=-2; am=osm; a=JetBrains%20Mono; t=JetBrains%20Mono; j=0f0c19; 7=15121f; 21=1f1c29;')
})();

