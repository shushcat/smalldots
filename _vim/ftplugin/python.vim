setlocal tabstop=4
setlocal expandtab
setlocal foldmethod=indent

vnoremap <silent> <Leader>s m'"ry :call tmux#SendText(@r . "\n")<CR>``
nnoremap <silent> <Leader>s m'vip"ry :call tmux#SendText(@r . "\n")<CR>``
