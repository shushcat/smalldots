let g:txta_note_files =  '/home/job/notes/*.md /home/job/notes/scratch'
let g:txta_buf_title = "txt-agenda"

function! txta#CleanupAgenda(job_id, code, event) dict
  let l:cmd = 'edit +'
	if a:code == 0
		let l:selection = split(getline(1), '\s')
		let l:num = l:selection[0]
		let l:file = join(l:selection[1:])
		bdelete! "txt-agenda"
		exec l:cmd . l:num l:file
	else
		bdelete! "txt-agenda"
	endif
endfunction

function! txta#ShowAgenda()
	let command = '/home/job/proj/txt-agenda/txt-agenda.sh ' . g:txta_note_files
	exec "enew"
  call termopen(command, {'on_exit': 'txta#CleanupAgenda'})
	setlocal statusline=%{g:txta_buf_title}
  setlocal nonumber
	setlocal syntax=off
  startinsert
endfunction

command! TXTAgenda call txta#ShowAgenda()
nnoremap <Leader>a :TXTAgenda<CR>
