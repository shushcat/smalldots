function! s:journal_file_date()
	if bufname("%") =~ "[0-9][0-9][0-9][0-9]-[0-9][0-9].md"
		let l:date = strpart(bufname("%"), match(bufname("%"), "[0-9][0-9][0-9][0-9]-[0-9][0-9].md"), 7)
		return l:date
	else
		return 0
	endif
endfunction

function! s:defer_unlist_buffer()
	au BufWinLeave <buffer> set nobuflisted
endfunction

function! journal#OpenJournal()
	" au BufWinLeave <buffer> set nobuflisted
	call s:defer_unlist_buffer()
	if !exists('g:journal_directory')
		echo "`g:journal_directory` is not set."
		return
	endif
  let l:date = strftime("%Y-%m")
  let l:filename = join([g:journal_directory, l:date, ".md"], "")
  execute 'edit ' . l:filename
endfunction

function! journal#NextJournalMonth()
	call s:defer_unlist_buffer()
	let l:date =  s:journal_file_date()
	if l:date == 0
		echo "The current buffer isn't a journal file."
		return
	else
		let l:year = l:date[0:3]
		let l:month = l:date[5:7]
		if l:month == "12"
			let l:year = printf("%04s", l:year + 1)
			let l:month = "01"
		else
			let l:month = printf("%02s", l:month + 1)
		endif
	endif
	let l:journal_path = g:journal_directory . l:year . "-" . l:month . ".md"
	exec 'edit ' . l:journal_path
endfunction

function! journal#PrevJournalMonth()
	call s:defer_unlist_buffer()
	let l:date =  s:journal_file_date()
	if l:date == 0
		echo "The current buffer isn't a journal file."
		return
	else
		let l:year = l:date[0:3]
		let l:month = l:date[5:7]
	endif
	if l:month == "01"
		let l:year = printf("%04s", l:year - 1)
		let l:month = "12"
	else
		let l:month = printf("%02s", l:month - 1)
	endif
	let l:journal_path = g:journal_directory . l:year . "-" . l:month . ".md"
	exec 'edit ' . l:journal_path
endfunction

nnoremap <C-PageUp> :call journal#PrevJournalMonth()<CR>
nnoremap <C-PageDown> :call journal#NextJournalMonth()<CR>

nnoremap <Leader>jr :call journal#OpenJournal()<CR>
vnoremap <Leader>jr d :call journal#OpenJournal()<CR>ggO<Esc>ggP

nnoremap <C-Home> :call journal#OpenJournal()<CR>
vnoremap <C-Home> d :call journal#OpenJournal()<CR>ggO<Esc>ggP
