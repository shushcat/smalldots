autocmd FileType minimd nmap <Leader>ms :setlocal spell!<CR>
autocmd FileType minimd iab <expr> ds strftime("[%Y-%m-%d]")

" Format markdown tables
autocmd FileType minimd nmap <Leader>mt vip:!sed 's/ *\| */ \| /g' \| column -t -s '\|' -o '\|'<CR>

function! minimd#Journal()
  let l:date = strftime("%Y-%m-%d")
  let l:filename = join(["~/notes/.journal/", l:date, ".md"], "")
  let l:cmd = 'edit'
  execute l:cmd l:filename
endfunction
nnoremap <Leader>jr :call minimd#Journal()<CR>
vnoremap <Leader>jr d :call minimd#Journal()<CR> ggO<Esc>ggP
function! TXTAgenda()
  " let l:filename = execute('edit term://txta')
  " new
  call bufadd("")
  call termopen('txta')
  " call termopen('txta', {'on_exit': 's:AgendaExit'})
  " call termopen('txta', {'on_stdout': {n,f->execute edit f}})
  " call system(termopen('txta'))
  " call jobstart('txta')
  setlocal nonumber
  startinsert
  " l:filename = termopen("txta")
  " let l:cmd = 'edit'
  " execute l:cmd l:filename
endfunction
function! s:AgendaExit(job_id, code, event) dict
    if a:code == 0
        close
    endif
endfun
nnoremap <Leader>a :call TXTAgenda()<CR>
