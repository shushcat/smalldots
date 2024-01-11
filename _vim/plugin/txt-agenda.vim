let g:txt_agenda_cmd = "txt-agenda"
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
	\ 'down': '60%',
	\ 'options': '--reverse --no-sort +s'})
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

function! s:agenda_tasks()
	if(v:servername=="")
		call remote_startserver(rand())
	endif
	let s:remote_expr = 'vim --servername ' . v:servername . ' --remote-expr "execute(\"wincmd p\")"'
	let s:remote_send = 'vim --servername ' . v:servername . ' --remote-send "<C-\><C-N>:edit +"'
	call fzf#run({
	\ 'source': 'agen "' . bufname("%"). '" | grep "TODO\|ACTV\|WAIT\|\[ \]"',
	\ 'sink':   function('s:fzf_selection_jump'),
	\ 'options': ['--delimiter=:', '--reverse', '--no-sort', '--with-nth=4..',
		\ '--bind=tab:execute(' . s:remote_expr . ')+execute(' .
		\ s:remote_send . '{3}\ {2}"<CR>")+execute(' . s:remote_expr . ')'],
	\ 'down': '40%'})
endfunction

" TODO Separate the jump and display functionality.
function! s:agenda_tasks_smooth()
	if(v:servername=="")
		call remote_startserver(rand())
	endif
	let l:main_window = win_getid()
	let l:bind_string_l = 'execute(vim --servername ' . v:servername .
		\ ' --remote-expr "win_execute(' . l:main_window . ', '
	let l:bind_string_r = ')")'
	call fzf#run({
	\ 'source': 'txt-agenda -p 12 -f 12 "' . bufname("%"). '" | grep "TODO\|ACTV\|WAIT\|\[ \]"',
	\ 'sink':   function('s:fzf_selection_jump'),
	\ 'options': [ '--delimiter=:', '--reverse', '--no-sort', '--with-nth=4..',
		\ '--bind=tab:' . l:bind_string_l . "{3}" . l:bind_string_r .
		\ '+' . l:bind_string_l . '\"redraw\"' . l:bind_string_r ],
	\ 'down': '40%'})
endfunction

command! TXTAgendaGlobal call TXTAgenda(g:txt_agenda_cmd . ' ./* ./*/*')
command! TXTAgendaLocal call TXTAgenda(g:txt_agenda_cmd . ' "' . bufname("%") . '"')

command! TXTAgendaInsert call TXTAgendaInsert(g:txt_agenda_cmd . ' -f * */*')

command! TXTAgendaLocalTasks call s:agenda_tasks_smooth()

nnoremap <Leader>A :TXTAgendaGlobal<CR>
nnoremap <Leader>a :TXTAgendaLocal<CR>

nnoremap <Leader>t :TXTAgendaLocalTasks<CR>
