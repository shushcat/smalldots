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

command! TXTAgendaGlobal call TXTAgenda(g:txt_agenda_cmd . ' -f * */*')
command! TXTAgendaLocal call TXTAgenda(g:txt_agenda_cmd . ' -f ' . bufname("%"))

nnoremap <Leader>a :TXTAgendaGlobal<CR>
nnoremap <Leader>a. :TXTAgendaLocal<CR>
