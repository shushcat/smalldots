let g:note_files =  "~/notes/*.md ~/notes/scratch"

function! txta#ShowAgenda()
	let l:txtacmd = '/home/jobrickley/proj/txt-agenda/txt-agenda.sh -f ' . g:note_files
	let l:fzf_escape = "'"
	let l:preview = '/home/jobrickley/proj/txt-agenda/txt-agenda.sh -p {}'

	call fzf#run({
		\ 'source': l:txtacmd,
		\ 'sink':   'e',
		\ 'options': '--tac --no-sort +s --delimiter=":" --preview-window=up --preview=' .
		\ l:fzf_escape . l:preview . l:fzf_escape,
		\ 'window':  'enew' })
endfunction

command! TXTAgenda call txta#ShowAgenda()
nnoremap <Leader>a :TXTAgenda<CR>
