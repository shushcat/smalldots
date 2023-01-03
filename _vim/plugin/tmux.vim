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
vnoremap <silent> <Leader>s "ry :call tmux#SendText(@r)<CR>
nnoremap <silent> <Leader>s vip"ry :call tmux#SendText(@r)<CR>
