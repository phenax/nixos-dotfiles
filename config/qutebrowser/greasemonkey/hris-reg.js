// ==UserScript==
// @name               Github PR helper
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Github PR helper
// @author             Akshay Nair
// @match              *://hris.peoplelabs.com/attendance/regularization/apply-regularization/*
// ==/UserScript==

const $ = document.querySelector.bind(document);

const keys = {
  r: () => {
    $('#firstintime').value = '10:30';
    $('#lastouttime').value = '18:30';
    $('#reason').value = 'Work from home';
    setTimeout(() => $('input[type="submit"]').click(), 500);
  },
};

document.addEventListener('keydown', (e) => {
  if (keys[e.key] && e.ctrlKey) {
    keys[e.key]();
  }
});


