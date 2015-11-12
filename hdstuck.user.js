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
// @version     1
// @grant       none
// ==/UserScript==

(window.dofsfload = function () {
    var sel_targets = "embed, object, iframe";
    console.log("Fullscreen Flash Objects loaded!");
    var st = document.createElement('style');
    st.type = 'text/css';
    st.appendChild(document.createTextNode(
        ".fullscreen .hide-when-fs { display: none; }" +
        ".fullscreen::before { display: none; }" +
        ".fullscreen::after { display: none; }"));
    document.head.appendChild(st);
    
    var observeDOM = (function(){
        var MutationObserver = window.MutationObserver || window.WebKitMutationObserver,
            eventListenerSupported = window.addEventListener;

        return function(obj, callback){
            if( MutationObserver ){
                // define a new observer
                var obs = new MutationObserver(function(mutations, observer){
                    if( mutations[0].addedNodes.length || mutations[0].removedNodes.length )
                        callback();
                });
                // have the observer observe foo for changes in children
                obs.observe( obj, { childList:true, subtree:true });
            }
            else if( eventListenerSupported ){
                obj.addEventListener('DOMNodeInserted', callback, false);
                obj.addEventListener('DOMNodeRemoved', callback, false);
            }
        }
    })();
    
    var handleflashobjects = function (where) {
        var embeds = where.querySelectorAll(sel_targets);
        for (var i = 0; i < embeds.length; i++) (function (embed) {
            if (embed.getAttribute('data-has-fs-btn')) return;
            embed.setAttribute('data-has-fs-btn', 'true');
            var btn = document.createElement('button');
            btn.innerHTML = "Fullscreen";
            btn.setAttribute('class', 'user-fullscreen-button hide-when-fs');
            btn.setAttribute('style', 'box-sizing: border-box; height: 1.5em; ' +
                    'margin-top: -1.5em;');

            embed.parentNode.insertBefore(btn, embed);
            btn.addEventListener('click', function () {
                var pn = embed.parentNode;
                window.my_current_fullscreen_embed = embed;
                if (pn.requestFullscreen) {
                    pn.requestFullscreen();
                } else if (pn.mozRequestFullScreen) {
                    pn.mozRequestFullScreen();
                } else if (pn.webkitRequestFullScreen) {
                    pn.webkitRequestFullScreen();
                } else if (embed.msRequestFullscreen) {
                    pn.msRequestFullscreen();
                } else {
                    console.log('No requestFullscreen');
                }
            }, false);
        })(embeds[i]);
    };
    handleflashobjects(document);
    observeDOM(document.body, function () { handleflashobjects(document); });
    var fsc_handler = function () {
        var fse = document.fullscreenElement;
        if (!fse) fse = document.mozFullScreenElement;
        if (!fse) fse = document.webkitFullScreenElement;
        if (!fse) fse = document.msFullscreenElement;
        if (fse) {
            fse.classList.add('fullscreen');
            var emb = window.my_current_fullscreen_embed;
            console.log('fullscreen on!');
            var height = screen.height;
            var ratio = height / emb.getAttribute('height');
            console.log("Setting data-orig-* on %o", fse);
            emb.setAttribute('data-orig-width', emb.getAttribute('width'));
            emb.setAttribute('data-orig-height', emb.getAttribute('height'));
            emb.setAttribute('height', height);
            emb.setAttribute('width', ratio * emb.getAttribute('width'));
            document.body.focus();
        } else {
            document.querySelector('.fullscreen').classList.remove(
                'fullscreen');
            console.log('fullscreen off!');
            var embeds = document.querySelectorAll(sel_targets);
            for (var i = 0; i < embeds.length; i++) {
                var emb = embeds[i];
                try {
                    emb.setAttribute('width',
                                     emb.getAttribute('data-orig-width'));
                    emb.setAttribute('height',
                                     emb.getAttribute('data-orig-height'));
                } finally {}
            }
        }
    };
    document.addEventListener('fullscreenchange', fsc_handler, false);
    document.addEventListener('mozfullscreenchange', fsc_handler, false);
    document.addEventListener('webkitfullscreenchange', fsc_handler, false);
    document.addEventListener('msfullscreenchange', fsc_handler, false);
})();
