if exists("b:python_ftplugin")
    finish
endif

set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set foldmethod=indent
set foldlevel=99

function! DateInsert()
    call cursor(7,1)
    if search('Last modified') != 0
        let line = line('.')
        call setline(line,"# Last modified: " . strftime("%Y-%m-%d %H:%M:%S"))
    endif
endfunction


function! TitleInsert()
    call setline(1,"#!/usr/bin/env python")
    call append(1,"# -*- coding:utf-8 -*-")
    call append(2,"#")
    call append(3,"# Shanbo Cheng: cshanbo@gmail.com")
    call append(4,"#")
    call append(5,"# Python release: Anaconda 2.7")
    call append(6,"#")
    call append(7,"# Date: " . strftime("%Y-%m-%d %H:%M:%S"))
    call append(8,"# Last modified: " . strftime("%Y-%m-%d %H:%M:%S"))
    call append(9,"")
    call append(10,"'''")
    call append(11,"'''")
    call append(12,"")
    call append(13,"from __future__ import print_function, unicode_literals, division")
    
endfunction

function! CommentBlock()
    "" Indent 
    :let s:myline = nextnonblank(".")
    :let s:myindent = indent(s:myline)
 
    " Make the string
    :let s:s = ""
    :let s:s2 = ""
    :let s:i = 0

    while s:i < s:myindent
    : let s:s = s:s . " "
    : let s:s2 = s:s2 . " "
    : let s:i += 1
    :endwhile

    :for i in range(1, 60-s:myindent)
    :    let s:s = s:s . "#"
    :endfor

    :let s:myline = line(".")
    call setline(s:myline, s:s)
    call append(s:myline, s:s2 . "#")
    call append(s:myline+1, s:s)
endfunction


:autocmd FileWritePre,BufWritePre *.py ks|call DateInsert()|'s
autocmd VimEnter * nested :TagbarOpen
let g:tagbar_left = 1

""auto VimEnter * :Voom python
:nmap <F2> :call TitleInsert()<CR>11Go
:nmap <F3> :call CommentBlock()<CR>jA 
:nmap <F5> :!python3 %<CR>
:nmap <F6> :!python %<CR>
:nmap <C-n> iif __name__ == '__main__<Esc>la:<Esc>o
"":inoremap " """<ESC>o"""<ESC>kA
:inoremap , , <ESC>a

"wincmd p
""auto VimEnter * wincmd w


"":nmap <silent> <F8> :Voom python<CR>

"设置代码折叠
set fdm=indent

"启动vim时关闭折叠代码
set nofoldenable


""let g:SuperTabMappingForward='<C-P>'
""let g:SuperTabMappingBackward='<S-C-P>'
