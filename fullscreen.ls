do window.dofsfload = !->
    sel-targets = "embed, object, iframe"
    console.log "Fullscreen Flash Objects loaded!"
    st = document.create-element 'style'
    st.type = 'text/css'

    st.append-child document.create-text-node """
        .fullscreen {
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: black;
        }

        .fullscreen .hide-when-fs {
            display: none;
        }
        .fullscreen::before {
            display: none;
        }
        .fullscreen::after {
            display: none;
        }
        .user-fullscreen-button {
            #{if /mspaintadventures\.com/.test(location.href) then """
            """ else """
                position: absolute;
                bottom: 100%;
            """}
        }
    """
    document.head.append-child st
    
    observe-dom = do ->
        MutationObserver =
            window.MutationObserver ? window.WebKitMutationObserver
        event-listener-supported = window.add-event-listener

        return (obj, callback) !->
            if MutationObserver?
                # define a new observer
                obs = new MutationObserver (mutations, observer) ->
                    if mutations[0].added-nodes.length ||
                            mutations[0].removedNodes.length
                        callback!

                # have the observer observe foo for changes in children
                obs.observe obj, child-list:true, subtree: true
            else if event-listener-supported
                obj.add-event-listener 'DOMNodeInserted', callback, false
                obj.add-event-listener 'DOMNodeRemoved', callback, false
    
    handle-flash-objects = (place) !->
        embeds = place.query-selector-all sel-targets

        for let embed in embeds
            if embed.get-attribute 'data-has-fs-btn' then return;
            embed.set-attribute 'data-has-fs-btn', 'true'
            btn = document.create-element 'button'
            btn.innerHTML = "Fullscreen"
            btn.set-attribute 'class', 'user-fullscreen-button hide-when-fs'

            embed.parent-node.insert-before btn, embed
            btn.add-event-listener 'click', !->
                pn = embed.parent-node
                window.my-current-fullscreen-embed = embed;
                bind = (obj, k) -> if obj?[k]?
                    -> obj[k].apply obj, ...
                else
                    null

                if pn.request-fullscreen?
                    pn.request-fullscreen!
                else if pn.moz-request-full-screen?
                    pn.moz-request-full-screen!
                else if pn.webkit-request-full-screen?
                    pn.webkit-request-full-screen!
                else if pn.ms-request-full-screen?
                    pn.ms-request-full-screen!
                else
                    console.log "No requestFullscreen"
            , false

    handle-flash-objects document
    observe-dom document.body, !-> handle-flash-objects document

    fsc-handler = !->
        fse = document.fullscreen-element
        unless fse? then fse = document.moz-full-screen-element
        unless fse? then fse = document.webkit-full-screen-element
        unless fse? then fse = document.ms-fullscreen-element
        if fse
            fse.class-list.add 'fullscreen'
            emb = window.my-current-fullscreen-embed
            console.log 'fullscreen on!'
            hratio = screen.height / emb.get-attribute 'height'
            wratio = screen.width / emb.get-attribute 'width'
            ratio = Math.min(hratio, wratio)

            console.log "Setting data-orig-* on %o", fse
            emb.set-attribute 'data-orig-width', emb.get-attribute 'width'
            emb.set-attribute 'data-orig-height', emb.get-attribute 'height'
            height = ratio * emb.get-attribute 'height'
            emb.set-attribute 'height', height
            width = ratio * emb.get-attribute 'width'
            if width == screen.width
                width -= 1 # leave one pixel to escape the flash's focus
            emb.set-attribute 'width', width
            document.body.focus!
        else
            document.query-selector('.fullscreen').class-list.remove(
                'fullscreen')
            console.log 'fullscreen off!'
            embeds = document.query-selector-all sel-targets
            for emb in embeds
                try
                    emb.set-attribute 'width',
                                     emb.get-attribute 'data-orig-width'
                    emb.set-attribute 'height',
                                     emb.get-attribute 'data-orig-height'
                finally
                    0

    document.add-event-listener 'fullscreenchange', fsc-handler, false
    document.add-event-listener 'mozfullscreenchange', fsc-handler, false
    document.add-event-listener 'webkitfullscreenchange', fsc-handler, false
    document.add-event-listener 'msfullscreenchange', fsc-handler, false
