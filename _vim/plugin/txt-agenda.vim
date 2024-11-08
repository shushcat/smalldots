let g:txt_agenda_cmd = "txt-agenda"
let s:fzf_escape = "'"

" Testing.
function! TXTAgendaQuickfix(txtacmd)
	" TODO Reformat list while matching?  The 'efm' value '%m:%f:%l:%s' also
	" works, but displays dates as messages.  In the current value, '%o' matches
	" a string designating a module name, which, despite yielding the desired
	" behavior (namely, my being able to check my schedule), has nothing to do
	" with what is actually going on. See ":help errorformat".
	let l:qfl = getqflist({'lines': systemlist(a:txtacmd), 'efm': '%o:%f:%l:%m'})
	call setqflist(get(l:qfl, 'items', []))
	exec "copen"
endfunction

command! TXTAgendaLocal call TXTAgendaQuickfix(g:txt_agenda_cmd . ' "' . bufname("%") . '"')
command! TXTAgendaGlobal call TXTAgendaQuickfix(g:txt_agenda_cmd . ' ./* ./*/* 2>/dev/null')

command! TXTAgendaLocalTasks call TXTAgendaQuickfix(g:txt_agenda_cmd . ' -p 12 -f 12 "' . bufname("%") . '" | grep "TODO\|ACTV\|WAIT\|\[ \]"')
command! TXTAgendaGlobalTasks call TXTAgendaQuickfix(g:txt_agenda_cmd . ' -p 12 -f 12 ./*.md | grep "TODO\|ACTV\|WAIT\|\[ \]"')

nnoremap <Leader>A :TXTAgendaGlobal<CR>
nnoremap <Leader>a :TXTAgendaLocal<CR>
nnoremap <Leader>t :TXTAgendaLocalTasks<CR>
nnoremap <Leader>T :TXTAgendaGlobalTasks<CR>
