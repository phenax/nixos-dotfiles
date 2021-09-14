// ==UserScript==
// @name               Slack helper
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Slack helper
// @author             Akshay Nair
// @match              *://app.slack.com/*
// ==/UserScript==

const keys = {};

document.addEventListener('keydown', (e) => {
  if (keys[e.key] && e.ctrlKey) {
    keys[e.key]();
  }
});

const notificationsButtons = () => document.querySelectorAll('[data-qa="banner"][class*=notifications] button');

let count = 0;
const timer = setInterval(() => {
  const $btns = notificationsButtons();

  console.log('>> [GM-N] Notification buttons', $btns);

  Array.from($btns)
    .filter($btn => $btn.textContent.match(/enable.*notification/gi))
    .forEach($btn => {
      $btn && $btn.click();
      clearInterval(timer);
      console.log('>> [GM-N] Enabled notifications')
    });

  if (count > 10) clearInterval(timer);
  count += 1;
}, 1000);

