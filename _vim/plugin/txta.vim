let g:txt_agenda_cmd = "txt-agenda"
let g:txt_agenda_files =  "~/notes/*.md ~/notes/scratch"

let s:txtacmd = g:txt_agenda_cmd . ' -f ' . g:txt_agenda_files
let s:preview = g:txt_agenda_cmd . ' -p {}'
let s:fzf_escape = "'"

function! s:fzf_selection_jump(line)
	let l:parts = split(a:line, ':')
	let l:file = l:parts[1]
	let l:linr = l:parts[2]
	exec 'edit +' . l:linr l:file 
endfunction

command! TXTAgenda	call fzf#run({
		\ 'source': s:txtacmd,
		\ 'sink':   function('s:fzf_selection_jump'),
		\ 'options': '--tac --no-sort +s --preview-window=up:wrap --preview=' .
		\ s:fzf_escape . s:preview . s:fzf_escape })

nnoremap <Leader>a :TXTAgenda<CR>
