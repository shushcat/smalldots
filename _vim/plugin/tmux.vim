" When using Tmux, create a vertical or horizontal split pane in the current
" working directory.
map <Leader>" :silent !tmux split-window -v<CR>
map <Leader>% :silent !tmux split-window -h<CR>

" Send either visually selected text or the current block to the
" marked Tmux pane.
function! tmux#SendText(text)
	let l:text = ('"' . escape(a:text, '\"$') . '"')
	call system("tmux send-keys -t'{marked}' " . l:text)
endfunction

command! TXTAgendaLocal call TXTAgenda(g:txt_agenda_cmd . ' -s -f "' . bufname("%") . '"')

" TODO Move the save (m') and restore (``) commands into SendText()
vnoremap <silent> <Leader>s m'"ry :call tmux#SendText(@r)<CR>``
nnoremap <silent> <Leader>s m'vip"ry :call tmux#SendText(@r)<CR>``

" Repeat the last command by sending an upward arrow followed by return
nnoremap <silent> <Leader>r :call tmux#SendText("\u001b[A\n")<CR>
