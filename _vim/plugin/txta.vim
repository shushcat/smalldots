let g:note_files =  '/home/job/notes/*.md /home/job/notes/scratch'

function! txta#CleanupAgenda(job_id, code, event) dict
  let l:cmd = 'edit +'
	if a:code == 0
		let l:selection = split(getline(1), '\s')
		let l:num = l:selection[0]
		let l:file = join(l:selection[1:])
		bdelete!
		exec l:cmd . l:num l:file
	endif
endfunction

function! txta#ShowAgenda()
	let command = '/home/job/proj/txt-agenda/txt-agenda.sh ' . g:note_files
  call bufadd("")
  call termopen(command, {'on_exit': 'txta#CleanupAgenda'})
	let b:term_title="txt-agenda"
	setlocal statusline=%{b:term_title}
  setlocal nonumber
	setlocal syntax=off
  startinsert
endfunction

command! TXTAgenda call txta#ShowAgenda()
nnoremap <Leader>a :TXTAgenda<CR>
