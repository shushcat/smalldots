let g:txt_agenda_cmd = "txt-agenda"

" Testing.
function! TXTAgendaQuickfix(txtacmd)
	" TODO Only adjust parentheses matching if it's enabled.
	exec ":NoMatchParen"
	autocmd FileType qf autocmd BufLeave <buffer> :DoMatchParen
	autocmd FileType qf autocmd BufEnter <buffer> :NoMatchParen
	" TODO Reformat list while matching?  The 'efm' value '%m:%f:%l:%s' also
	" works, but displays dates as messages.  In the current value, '%o' matches
	" a string designating a module name, which, despite yielding the desired
	" behavior (namely, my being able to check my schedule), has nothing to do
	" with what is actually going on. See ":help errorformat".
	let l:qfl = getqflist({'lines': systemlist(a:txtacmd), 'efm': '%o:%f:%l:%m'})
	call setqflist(get(l:qfl, 'items', []))
	call setqflist([], 'r', {'title': 'txt-agenda'})
	exec "copen"
endfunction

command! TXTAgendaLocal call TXTAgendaQuickfix(g:txt_agenda_cmd . ' "' . bufname("%") . '" 2>/dev/null')
command! TXTAgendaGlobal call TXTAgendaQuickfix(g:txt_agenda_cmd . ' ./* ./*/* 2>/dev/null')

command! TXTAgendaLocalTasks call TXTAgendaQuickfix(g:txt_agenda_cmd . ' -p 12 -f 12 "' . bufname("%") . '" | grep "TODO\|ACTV\|WAIT\|\[ \]" 2>/dev/null')
command! TXTAgendaGlobalTasks call TXTAgendaQuickfix(g:txt_agenda_cmd . ' -p 12 -f 12 ./* ./*/* 2>/dev/null | grep "TODO\|ACTV\|WAIT\|\[ \]" 2>/dev/null')

" Don't allow trying to build a new agenda while in a quickfix buffer since
" bufname("%") won't be what you want in that case.
autocmd FileType qf nnoremap <buffer> <Leader>A <nop>
autocmd FileType qf nnoremap <buffer> <Leader>a <nop>
autocmd FileType qf nnoremap <buffer> <Leader>T <nop>
autocmd FileType qf nnoremap <buffer> <Leader>t <nop>

nnoremap <Leader>A :TXTAgendaGlobal<CR>
nnoremap <Leader>a :TXTAgendaLocal<CR>
nnoremap <Leader>T :TXTAgendaGlobalTasks<CR>
nnoremap <Leader>t :TXTAgendaLocalTasks<CR>
