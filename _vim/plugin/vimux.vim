 map <Leader>vp :VimuxPromptCommand<CR>
 map <Leader>vl :VimuxRunLastCommand<CR>
 map <Leader>vi :VimuxInspectRunner<CR>
 map <Leader>vq :VimuxCloseRunner<CR>
 map <Leader>vx :VimuxInterruptRunner<CR>
 map <Leader>vz :call VimuxZoomRunner()<CR>

function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

vmap <Leader>vs "vy :call VimuxSlime()<CR>
nmap <Leader>vs vip<Leader>vs<CR>
