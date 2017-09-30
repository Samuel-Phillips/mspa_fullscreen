let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/code/mspa_fullscreen
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +5 fullscreen.ls
badd +7 Makefile
badd +15 build_site_specific.sh
badd +0 term://.//24424:/usr/bin/fish
badd +0 site_specific/miniclip_special.ls
badd +0 site_specific/mspaintadventures.ls
argglobal
silent! argdel *
argadd fullscreen.ls
edit site_specific/miniclip_special.ls
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
exe '1resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 92 + 92) / 185)
exe '2resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 92 + 92) / 185)
exe '3resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 92 + 92) / 185)
exe '4resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 92 + 92) / 185)
exe '5resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 5resize ' . ((&columns * 92 + 92) / 185)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
2
normal! zo
3
normal! zo
11
normal! zo
let s:l = 18 - ((15 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
normal! 016|
lcd ~/code/mspa_fullscreen
wincmd w
argglobal
edit ~/code/mspa_fullscreen/site_specific/mspaintadventures.ls
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
2
normal! zo
5
normal! zo
let s:l = 4 - ((3 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 020|
lcd ~/code/mspa_fullscreen
wincmd w
argglobal
edit term://.//24424:/usr/bin/fish
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 19 - ((14 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
19
normal! 0
lcd ~/code/mspa_fullscreen
wincmd w
argglobal
edit /usr/share/nvim/runtime/doc/starting.txt
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let s:l = 815 - ((21 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
815
normal! 032|
wincmd w
argglobal
edit ~/code/mspa_fullscreen/fullscreen.ls
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
12
normal! zo
13
normal! zo
18
normal! zo
26
normal! zo
72
normal! zo
75
normal! zo
83
normal! zo
106
normal! zo
let s:l = 48 - ((13 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
48
normal! 09|
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 92 + 92) / 185)
exe '2resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 92 + 92) / 185)
exe '3resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 92 + 92) / 185)
exe '4resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 92 + 92) / 185)
exe '5resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 5resize ' . ((&columns * 92 + 92) / 185)
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
