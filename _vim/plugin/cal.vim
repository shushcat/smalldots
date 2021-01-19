function! ShowCalendar()
	let s:cal_output = system("cal -3")
	echo s:cal_output
endfunction
nmap <silent> <Leader>c3 :call ShowCalendar()<CR>
