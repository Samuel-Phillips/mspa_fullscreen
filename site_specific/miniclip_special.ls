export default do
    test: -> //^
        https?:\//
        www.miniclip.com/games/
            [^/]*/ # game name
            [^/]*/ # language
            focus/\#t-fm\/
    //.test location.href

    newstyle: -> """
        .fullscreen {
            position: static;
        }
    """

    filter-objects: (element) -> true

    extra-objects: -> []
