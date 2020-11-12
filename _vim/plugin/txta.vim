let g:txt_agenda_files =  "~/notes/*.md ~/notes/scratch"
let g:txt_agenda_cmd = "txt-agenda"

function! s:fzf_selection_jump(line)
	let l:parts = split(a:line, ':')
	let l:file = l:parts[1]
	let l:linr = l:parts[2]
	exec 'edit +' . l:linr l:file 
endfunction

function! txta#ShowAgenda()
	let l:txtacmd = g:txt_agenda_cmd . ' -f ' . g:txt_agenda_files
	let l:fzf_escape = "'"
	let l:preview = g:txt_agenda_cmd . ' -p {}'
	call fzf#run({
		\ 'source': l:txtacmd,
		\ 'sink':   function('s:fzf_selection_jump'),
		\ 'options': '--tac --no-sort +s --preview-window=up:wrap --preview=' .
		\ l:fzf_escape . l:preview . l:fzf_escape,
		\ 'window':  'enew' })
endfunction

" FIXME When invoked immediately after file selection, <Leader> must be
" pressed twice.
command! TXTAgenda call txta#ShowAgenda()
nnoremap <Leader>a :TXTAgenda<CR>
