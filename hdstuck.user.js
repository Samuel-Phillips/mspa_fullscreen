// ==UserScript==
// @name        Fullscreen Flash objects
// @namespace   samuelphillips.net
// @include http://www.mspaintadventures.com/*
// @include https://www.mspaintadventures.com/*
// @include http://www.newgrounds.com/portal/view/*
// @include https://www.newgrounds.com/portal/view/*
// @include http://www.miniclip.com/games/*/*/*
// @include https://www.miniclip.com/games/*/*/*
// @include http://www.engineering.com/GamesPuzzles/Motherload/tabid/4708/Default.aspx
// @include http://www.kongregate.com/games/*/*
// @include https://www.kongregate.com/games/*/*
// @version     2.1
// @grant       none
// ==/UserScript==

// Generated by LiveScript 1.5.0
/*
 * COPYRIGHT 2017 Samuel Phillips
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * The source code for this script can be found at the following URL:
 * https://github.com/Samuel-Phillips/mspa_fullscreen
 */
(function(){
  (window.dofsfload = function(){
    var selTargets, st, observeDom, handleFlashObjects, root, fscHandler;
    selTargets = "embed, object, iframe";
    console.log("Fullscreen Flash Objects loaded!");
    st = document.createElement('style');
    st.type = 'text/css';
    st.appendChild(document.createTextNode(".fullscreen {\n    display: flex;\n    justify-content: center;\n    align-items: center;\n    background-color: black;\n}\n\n.fullscreen .hide-when-fs {\n    display: none;\n}\n.fullscreen::before {\n    display: none;\n}\n.fullscreen::after {\n    display: none;\n}\n.user-fullscreen-button {\n    " + (/mspaintadventures\.com/.test(location.href) ? "" : "position: absolute;\nbottom: 100%;") + "\n}"));
    document.head.appendChild(st);
    observeDom = function(){
      var MutationObserver, ref$, eventListenerSupported;
      MutationObserver = (ref$ = window.MutationObserver) != null
        ? ref$
        : window.WebKitMutationObserver;
      eventListenerSupported = window.addEventListener;
      return function(obj, callback){
        var obs;
        if (MutationObserver != null) {
          obs = new MutationObserver(function(mutations, observer){
            if (mutations[0].addedNodes.length || mutations[0].removedNodes.length) {
              return callback();
            }
          });
          obs.observe(obj, {
            childList: true,
            subtree: true
          });
        } else if (eventListenerSupported) {
          obj.addEventListener('DOMNodeInserted', callback, false);
          obj.addEventListener('DOMNodeRemoved', callback, false);
        }
      };
    }();
    handleFlashObjects = function(place){
      var embeds, i$, len$;
      embeds = place.querySelectorAll(selTargets);
      for (i$ = 0, len$ = embeds.length; i$ < len$; ++i$) {
        (fn$.call(this, embeds[i$]));
      }
      function fn$(embed){
        var btn;
        if (embed.getAttribute('data-has-fs-btn')) {
          return;
        }
        embed.setAttribute('data-has-fs-btn', 'true');
        btn = document.createElement('button');
        btn.innerHTML = "Fullscreen";
        btn.setAttribute('class', 'user-fullscreen-button hide-when-fs');
        embed.parentNode.insertBefore(btn, embed);
        btn.addEventListener('click', function(){
          var pn, bind;
          pn = embed.parentNode;
          window.myCurrentFullscreenEmbed = embed;
          bind = function(obj, k){
            if ((obj != null ? obj[k] : void 8) != null) {
              return function(){
                return obj[k].apply(obj);
              };
            } else {
              return null;
            }
          };
          if (pn.requestFullscreen != null) {
            pn.requestFullscreen();
          } else if (pn.mozRequestFullScreen != null) {
            pn.mozRequestFullScreen();
          } else if (pn.webkitRequestFullScreen != null) {
            pn.webkitRequestFullScreen();
          } else if (pn.msRequestFullScreen != null) {
            pn.msRequestFullScreen();
          } else {
            console.log("No requestFullscreen");
          }
        }, false);
      }
    };
    root = document.body;
    if (/www\.newgrounds\.com/.test(location.href)) {
      console.log("I think this is newgrounds");
      root = document.querySelector('#embed_wrapper');
    }
    handleFlashObjects(document);
    observeDom(root, function(){
      handleFlashObjects(document);
    });
    fscHandler = function(){
      var fse, emb, hratio, wratio, ratio, height, width, embeds, i$, len$;
      fse = document.fullscreenElement;
      if (fse == null) {
        fse = document.mozFullScreenElement;
      }
      if (fse == null) {
        fse = document.webkitFullScreenElement;
      }
      if (fse == null) {
        fse = document.msFullscreenElement;
      }
      if (fse) {
        fse.classList.add('fullscreen');
        emb = window.myCurrentFullscreenEmbed;
        console.log('fullscreen on!');
        hratio = screen.height / emb.getAttribute('height');
        wratio = screen.width / emb.getAttribute('width');
        ratio = Math.min(hratio, wratio);
        console.log("Setting data-orig-* on %o", fse);
        emb.setAttribute('data-orig-width', emb.getAttribute('width'));
        emb.setAttribute('data-orig-height', emb.getAttribute('height'));
        height = ratio * emb.getAttribute('height');
        emb.setAttribute('height', height);
        width = ratio * emb.getAttribute('width');
        if (width === screen.width) {
          width -= 1;
        }
        emb.setAttribute('width', width);
        document.body.focus();
      } else {
        document.querySelector('.fullscreen').classList.remove('fullscreen');
        console.log('fullscreen off!');
        embeds = document.querySelectorAll(selTargets);
        for (i$ = 0, len$ = embeds.length; i$ < len$; ++i$) {
          emb = embeds[i$];
          try {
            emb.setAttribute('width', emb.getAttribute('data-orig-width'));
            emb.setAttribute('height', emb.getAttribute('data-orig-height'));
          } finally {
            0;
          }
        }
      }
    };
    document.addEventListener('fullscreenchange', fscHandler, false);
    document.addEventListener('mozfullscreenchange', fscHandler, false);
    document.addEventListener('webkitfullscreenchange', fscHandler, false);
    document.addEventListener('msfullscreenchange', fscHandler, false);
  })();
}).call(this);
