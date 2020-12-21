// ==UserScript==
// @name               Whatsapp helper
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Whatsapp helper
// @author             Akshay Nair
// @match              *://web.whatsapp.com/*
// ==/UserScript==


const getPosition = $el => parseInt($el.style.transform.match(/translateY\((.*)\)/)[1], 10);

const getContacts = () => Array.from(document
  .querySelectorAll('#pane-side > div:nth-child(1) > div > div > div'))
  .sort(($a, $b) => getPosition($a) - getPosition($b))

const getNext = () => {
  const list = getContacts();
  const current_selected = list.findIndex($el => !!$el.querySelector('[aria-selected=true]'));
  return list[current_selected + 1];
};
const getPrev = () => {
  const list = getContacts();
  const current_selected = list.findIndex($el => !!$el.querySelector('[aria-selected=true]'));
  return current_selected <= 0 ? null : list[current_selected - 1];
};

const clickableElem = $el => $el && $el.querySelector('[aria-selected] > div');

const click = $el => $el && $el.dispatchEvent(new MouseEvent('mousedown', {
  screenX: 5,
  screenY: 5,
  bubbles: true,
  cancellable: true,
  relatedTarget: $el,
}));

const keys = {
  j: () => click(clickableElem(getNext())),
  k: () => click(clickableElem(getPrev())),
};

document.addEventListener('keydown', (e) => {
  if (keys[e.key] && e.ctrlKey) {
    keys[e.key]();
  }
});

const timer = setInterval(() => {
  if (Notification.permission !== 'default') {
    clearInterval(timer);
    return;
  }

  Notification.requestPermission().then(console.log);
}, 1000);

