autocmd FileType minimd nmap <Leader>ms :setlocal spell!<CR>
autocmd FileType minimd iab <expr> ds strftime("[%Y-%m-%d]")

" Format markdown tables
autocmd FileType minimd nmap <Leader>mt vip:!sed 's/ *\| */\@\@\| /g' \| column -t -s '@@'<CR>

function! minimd#Journal()
  let l:date = strftime("%Y-%m")
  let l:filename = join(["~/notes/.journal/", l:date, ".md"], "")
  let l:cmd = 'edit'
  execute l:cmd l:filename
endfunction
nnoremap <Leader>jr :call minimd#Journal()<CR>
vnoremap <Leader>jr d :call minimd#Journal()<CR>ggO<Esc>ggP
