" Strip extra whitespace when sending to SQL.
function sql#SendText(text)
	let send_text = substitute(a:text, '\s', " ", "g")
	call tmux#SendText(send_text)
endfunction
