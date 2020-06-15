" Vim filetype plugin
" Language:     Minimal Markdown
" Author:       J. O. Brickley

if exists("g:minimd_plugin_loaded")
    finish
endif

" Folding:
setlocal foldmethod=manual
setlocal foldopen-=search
setlocal foldtext=minimd#FoldText()
function! minimd#FoldText()
        let line = getline(v:foldstart)
        let folded_line_num = v:foldend - v:foldstart
        let line_text = substitute(line, '\(.\{56\}.\{-\}\)\s.*', '\1', 'g')
        let fillcharcount = 70 - len(line_text) - len(folded_line_num)
        return line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' Lines)'
endfunction
setlocal fillchars=fold:\ 
nmap <silent> <Space> :call minimd#ManualFold()<CR>

" Formatting:
setlocal formatoptions+=1tcqljn 
setlocal formatoptions-=ro
setlocal formatlistpat="^\s*\(-\|*\|+\|\d\+\.\)\s"
setlocal wrap
setlocal wrapmargin=0
setlocal textwidth=0
setlocal nolist
setlocal linebreak
setlocal breakat&vim
setlocal display=lastline
setlocal autoindent
setlocal nosmartindent
setlocal comments=fb:*,fb:+,fb:-,n:>
setlocal commentstring=<!--%s-->
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=2
setlocal formatoptions+=n
setlocal nocindent
setlocal number
setlocal shiftwidth=4

" Headers:
nmap <silent> <Tab> :call minimd#HeaderMotion('F')<CR>
nmap <silent> <S-Tab> :call minimd#HeaderMotion('B')<CR>
nnoremap <silent> = :call minimd#PromoteHeader()<CR>
nnoremap <silent> - :call minimd#DemoteHeader()<CR>

" Motion:
nmap j gj
nmap k gk

" Tasks:
nmap <silent><buffer> <CR> :call minimd#TaskToggle()<CR>
vmap <silent><buffer> <CR> :call minimd#TaskToggle()<CR>

" Word Count:
let b:word_count = minimd#UpdateWordCount()
set statusline=%<%f\ wc:%{minimd#ReturnWordCount()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

let g:minimd_plugin_loaded = 1
