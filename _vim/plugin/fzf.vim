if !exists('g:loaded_fzf')
	finish
endif

nnoremap <Leader>L :FZFAllLines<CR>
nnoremap <Leader>b :FZFBuffers<CR>
nnoremap <Leader>f :FZFFiles<CR>
nnoremap <Leader>g :FZFGrep<CR>
nnoremap <Leader>h :FZFHLines<CR>
nnoremap <Leader>l :FZFBLines<CR>

function! s:file_line_jump(l)
  let keys = split(a:l, ':')
	exec "e " . keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let l:lines = []
	call extend(l:lines, map(getline(0,"$"), '(v:key + 1) . "\t" . v:val '))
  return l:lines
endfunction

function! s:all_lines()
	let l:alines = systemlist("find -H * -type f -not -path '*/\.*' -exec awk '{print FILENAME \":\" FNR \":\" $0}' '{}' \\;")
	return l:alines
endfunction

function! s:header_lines()
	let l:blines = s:buffer_lines()
  let l:hlines = []
	for line in l:blines
		if line =~ "^[0-9]*[	]#[ ]" || line =~ "^[0-9]*[	]##[ ]"
			let line = substitute(line, '^\([0-9]*\)	\(.*\)$', '\2	\1', "")
			call add(l:hlines, line)
		endif
	endfor
  return l:hlines
endfunction

function! s:hline_jump(l)
  let keys = split(a:l, '\t')
  exec keys[-1]
  normal! ^zz
endfunction

function! s:line_jump(l)
  let keys = split(a:l, '\t')
  exec keys[0]
  normal! ^zz
endfunction

function! s:other_buffers()
	let l:buffers = []
	for n in range(1, bufnr('$'))
		if bufname("%") != bufname(n) && bufname(n) != bufname("#") && buflisted(bufname(n)) 
			call add(l:buffers, bufname(n))
		endif
	endfor
	call insert(l:buffers, bufname("#"))
	return l:buffers
endfunction

command! FZFAllLines call fzf#run({
			\ 'source':		<sid>all_lines(),
			\ 'sink':			function('<sid>file_line_jump'),
			\ 'down':			'60%'
			\})

command! FZFBLines call fzf#run({
			\ 'source':  <sid>buffer_lines(),
			\ 'sink':    function('<sid>line_jump'),
			\ 'options': '--tac --nth=2..',
			\ 'down':    '60%'
			\})

command! FZFBuffers call fzf#run({
			\ 'source':  <sid>other_buffers(),
			\ 'sink':    'buffer',
			\ 'down':    '60%'
			\})

command! FZFFiles call fzf#run({
		\ 'source': "find -L * -type f -not -path '*/\.*'",
		\ 'sink':   'e',
		\ 'down': '60%' 
		\})

command! FZFGrep call fzf#run({
			\ 'source':  'rg -S -n "' . input("FZFGrep: ") . '"',
			\ 'sink':    function('<sid>file_line_jump'),
			\ 'down':    '60%'
			\})

command! FZFHLines call fzf#run({
			\ 'source':  <sid>header_lines(),
			\ 'sink':    function('<sid>hline_jump'),
			\ 'options': '--nth=2.. --reverse',
			\ 'left':    '30%'
			\})

autocmd! FileType fzf
autocmd FileType fzf setlocal laststatus=0 noshowmode noruler
