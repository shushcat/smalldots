function! VimuxPySlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
  call VimuxSendKeys("Enter")
endfunction

vnoremap <Leader>vs "vy :call VimuxPySlime()<CR>

setlocal tabstop=4
setlocal expandtab
