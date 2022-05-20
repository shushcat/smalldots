let g:txt_agenda_cmd = "txt-agenda"
let s:preview = g:txt_agenda_cmd . ' -p {}'
let s:fzf_escape = "'"

function! s:fzf_selection_jump(line)
	let l:parts = split(a:line, ':')
	let l:file = l:parts[1]
	let l:linr = l:parts[2]
	exec 'edit +' . l:linr l:file 
endfunction

function! TXTAgenda(txtacmd)
call fzf#run({
	\ 'source': a:txtacmd,
	\ 'sink':   function('s:fzf_selection_jump'),
	\ 'options': '--tac --no-sort +s --preview-window=up:wrap --preview=' .
	\ s:fzf_escape . s:preview . s:fzf_escape })
endfunction

function! TXTAgendaInsert(txtacmd)
	let l:output = split(system(a:txtacmd), '\n')
	let l:items = []
	for line in l:output
		if line =~ "^[[0-9][0-9][0-9][0-9]"
			call add(l:items, line)
		endif
	endfor
	call append('.', l:items)
endfunction

command! TXTAgendaGlobal call TXTAgenda(g:txt_agenda_cmd . ' -f * */*')
command! TXTAgendaLocal call TXTAgenda(g:txt_agenda_cmd . ' -f "' . bufname("%") . '"')
command! TXTAgendaInsert call TXTAgendaInsert(g:txt_agenda_cmd . ' -f * */*')

nnoremap <Leader>a :TXTAgendaGlobal<CR>
nnoremap <Leader>a. :TXTAgendaLocal<CR>
nnoremap <Leader>ai :TXTAgendaInsert<CR>
