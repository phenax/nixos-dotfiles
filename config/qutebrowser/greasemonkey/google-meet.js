// ==UserScript==
// @name               Google meet mute indicator
// @namespace          phenax.github.io
// @version            0.0.0
// @description        Google meet mute indicator
// @author             Akshay Nair
// @match              *://meet.google.com/*
// ==/UserScript==

(() => {
  const log = console.log.bind(console, '[MeetingBtns]');
  const $$ = document.querySelectorAll.bind(document);

  const $indicator = document.createElement('div');
  Object.assign($indicator.style, {
    backgroundColor: 'red',
    width: '200px',
    height: '100px',
    position: 'fixed',
    zIndex: 90000,
    left: 0,
    top: 0,
    opacity: 0,
  });

  const getMuteBtns = () => Array.from($$('[data-is-muted][role="button"]'));

  const updateMuteState = () => {
    try {
      const $btns = getMuteBtns();
      const $mutedBtns = $btns.filter($btn => $btn.dataset.isMuted === 'true');
      Object.assign($indicator.style, {
        opacity: $mutedBtns.length === $btns.length ? 0 : 1,
      });
    } catch (e) { log('update error', e); }
  };

  const observer = new MutationObserver(diffs => {
    log('mutation observer');
    const muteChange = diffs.find(d => d.attributeName === 'data-is-muted');
    if (!!muteChange) {
      log('updating mute state');
      updateMuteState();
    }
  });

  const init = () => {
    const $muteBtns = getMuteBtns();
    log('initializing', $muteBtns);
    document.body.appendChild($indicator);

    $muteBtns.forEach($btn => {
      observer.observe($btn, { attributes: true, attributeFilter: ['data-is-muted'] });
      updateMuteState();
    });

    if (window.$$$muteObserver) window.$$$muteObserver.disconnect();
    window.$$$muteObserver = observer;
  };

  const timer = setInterval(() => {
    const $btns = getMuteBtns();
    const hasJoinedMeeting = $$('[data-meeting-code]').length === 0;
    log('checking if joined...', hasJoinedMeeting);
    if ($btns.length > 0 && hasJoinedMeeting) {
      setTimeout(() => init(), 1000);
      clearInterval(timer);
    }
  }, 500);


  /////////////////////// Push to talk

  // let isSpacePressed = false
  // const setSpacePressed = p => {
  //   isSpacePressed = p
  // }

  // window.addEventListener('keydown', e => {
  //   if (e.key === 'space') {
  //     setSpacePressed(true)
  //   }
  // })
  // window.addEventListener('keydown', e => {
  //   if (e.key === 'space') {
  //     setSpacePressed(false)
  //   }
  // })
})();

