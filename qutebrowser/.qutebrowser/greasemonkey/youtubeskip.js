// ==UserScript==
// @name         Youtube Ad Skip
// @version      0.0.4
// @description  auto skip Youtube ads
// @author       Adcott
// @match        *://*.youtube.com/*
// ==/UserScript==

document.addEventListener('load', () => {
        try { document.querySelector('.ad-showing video').currentTime = 99999 } catch {}
        try { document.querySelector('.ytp-ad-skip-button').click() } catch {}
}, true);
