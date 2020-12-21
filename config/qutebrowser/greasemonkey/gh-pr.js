// ==UserScript==
// @name               Github PR helper
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Github PR helper
// @author             Akshay Nair
// @match              *://github.com/*/pull/*/files
// ==/UserScript==

const keys = {
  n: () => document.querySelector('.js-reviewed-toggle:not(.js-reviewed-file)').click(),
  N: () => Array.from(document.querySelectorAll('.js-reviewed-file')).slice(-1)[0].click(),
  //j: () => {
    //const $el = document.querySelector('.js-reviewed-toggle:not(.js-reviewed-file)');
    //if ($el) {
      
    //}
  //},
};

document.addEventListener('keydown', (e) => {
  console.log(e.key, e.ctrlKey);
  if (keys[e.key] && e.ctrlKey) {
    keys[e.key]();
  }
});

