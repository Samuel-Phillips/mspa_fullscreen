export default do
    test: -> /mspaintadventures\.com/.test location.href

    newstyle: -> """
        .fullscreen {
            position: static;
        }
    """

    filter-objects: (element) -> true

    extra-objects: -> []
