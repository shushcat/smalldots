function! ShowCalendar()
	let s:date_output = system("date +'%A, %d %B %Y\n'")
	echo s:date_output
	let s:cal_output = system("cal -3h")
	echo s:cal_output
endfunction
nmap <silent> <Leader>c3 :call ShowCalendar()<CR>
