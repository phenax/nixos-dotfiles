// ==UserScript==
// @name               Hide youtube google ad
// @namespace          vince.youtube
// @version            2.4.1
// @description        hide youtube google ad,auto click "skip ad"
// @author             vince ding
// @match              *://www.youtube.com/*
// ==/UserScript==

(function() {
    'use strict';
    var closeAd=function (){
        var css = '.video-ads .ad-container .adDisplay,#player-ads,.ytp-ad-module,.ytp-ad-image-overlay{ display: none!important; }',
            head = document.head || document.getElementsByTagName('head')[0],
            style = document.createElement('style');

        style.type = 'text/css';
        if (style.styleSheet){
            style.styleSheet.cssText = css;
        } else {
            style.appendChild(document.createTextNode(css));
        }

        head.appendChild(style);
    };
    var skipInt;
    var log=function(msg){
      console.log(msg);
    };
    var skipAd=function(){
        //ytp-ad-preview-text
        //ytp-ad-skip-button
        var skipbtn=document.querySelector(".ytp-ad-skip-button.ytp-button")||document.querySelector(".videoAdUiSkipButton ");
        //var skipbtn=document.querySelector(".ytp-ad-skip-button ")||document.querySelector(".videoAdUiSkipButton ");
        if(skipbtn){
           skipbtn=document.querySelector(".ytp-ad-skip-button.ytp-button")||document.querySelector(".videoAdUiSkipButton ");
           log("skip");
           skipbtn.click();
           if(skipInt) {clearTimeout(skipInt);}
           skipInt=setTimeout(skipAd,500);
         }else{
              log("checking...");
              if(skipInt) {clearTimeout(skipInt);}
              skipInt=setTimeout(skipAd,500);
         }
    };

    closeAd();
    skipAd();

})();
