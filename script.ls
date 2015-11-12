function create_fs_tgt image title bodyelements
    fstgt = document.createElement 'div'
    fstgt.id = "fullscr-tgt"
    imwrap = document.createElement 'div'
    imwrap.className = "imwrap"
    remainder = document.createElement 'div'
    remainder.className = "remainder"
    h1 = document.createElement 'h1'
    fstgt.appendChild imwrap
    imwrap.appendChild image
    fstgt.appendChild remainder
    remainder.appendChild h1
    h1.appendChild title
    for be in bodyelements
        remainder.appendChild be
    return fstgt

mycss = """
\#fullscr-tgt {
}
\#fullscr-tgt .imwrap {
}
\#fullscr-tgt .imwrap * {
}
\#fullscr-tgt .remainder {
}
\#fullscr-tgt .remainder h1 {
}
.hideme {
    display: none;
}
"""

function set_fullscreen
    pagereg = document.querySelector """
        body > center:nth-child(1) > table:nth-child(1)
        > tbody:nth-child(1) > tr:nth-child(2)
        > td:nth-child(1) > table:nth-child(1)
        > tbody:nth-child(1) > tr:nth-child(1)
        > td:nth-child(1) > table:nth-child(1)
        > tbody:nth-child(1) > tr:nth-child(2)
        > td:nth-child(1) > center:nth-child(1)
        > table:nth-child(1)"""
    title = pagereg.querySelector """
        tr:nth-child(1) > td:nth-child(1) > table:nth-child(1)
        > tbody > tr:nth-child(1) > td:nth-child(2) font"""
    image = pagereg.querySelector """
        tr:nth-child(2) > td:nth-child(1) > center"""
    body = []
    fs_tgt = create_fs_tgt(image, title, body)








