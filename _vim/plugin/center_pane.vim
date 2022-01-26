if exists('g:loaded_center_pane')
	finish
endif

let s:foldcolumn_default = &foldcolumn
let s:laststatus_default = &laststatus
let s:number_default = &number
let s:numberwidth_default = &numberwidth
let s:ruler_default = &ruler
let s:tabline_default = &tabline
let s:guioptions_default = &guioptions
let s:guicursor_default = &guicursor
let s:padname = '_center_pane_pad_'

function! s:set_colors()
	let l:normalhl = execute("hi Normal")
	if match(l:normalhl, "ctermbg") == -1
		let l:termbg="black"
	else
		let l:termbg = substitute(execute("hi Normal"), '.*ctermbg=\(\S*\).*', '\1', '')  
	endif
	if match(l:normalhl, "guibg") == -1
		let l:guibg="#000000"
	else
		let l:guibg = substitute(execute("hi Normal"), '.*guibg=\(\S*\).*', '\1', '')  
	endif
	exec "hi VertSplit guifg=" . l:guibg "guibg=" . l:guibg "ctermfg=" . l:termbg "ctermbg=" . l:termbg
  exec "hi NonText guifg=" . l:guibg "guibg=" . l:guibg "ctermfg=" . l:termbg "ctermbg=" . l:termbg
	exec "hi EndOfBuffer guifg=" . l:guibg "guibg=" . l:guibg "ctermfg=" . l:termbg "ctermbg=" . l:termbg
endfunction

function! s:remove_center_pane_pads()
	augroup CenterPane | au! | augroup END
	let l:pad_bufnr = bufnr(s:padname)
	exec "bwipeout " . l:pad_bufnr
	silent wincmd o
	execute 'set foldcolumn=' . s:foldcolumn_default
	let &laststatus = s:laststatus_default
	execute 'set numberwidth=' . s:numberwidth_default
	let &ruler = s:ruler_default
	execute 'set tabline=' . s:tabline_default
	execute 'set guioptions=' . s:guioptions_default
	execute 'set guicursor=' . s:guicursor_default
	execute 'colorscheme' g:colors_name
endfunction

function! s:create_center_pane_pads()
	set foldcolumn=0 laststatus=0 numberwidth=1 noruler showtabline=0
	set guioptions-=rL
	set guicursor+=a:blinkon0
	let l:width = &columns / 3
	let l:window_params = l:width . 'vsplit +setlocal\ buftype=nofile\ bufhidden=wipe\ nomodifiable\ noswapfile\ nobuflisted\ nonumber ' . s:padname
	execute 'keepalt topleft' . l:window_params | wincmd p
	execute 'keepalt botright' . l:window_params | wincmd p
	augroup CenterPane
		autocmd BufLeave <buffer> call s:remove_center_pane_pads()
	augroup END
	execute "redraw!"
endfunction

function! CenterPaneToggle()
	call s:set_colors()
  set noequalalways
  if bufwinnr(s:padname) > 0
		call s:remove_center_pane_pads()
  else
		call s:create_center_pane_pads()
  endif
endfunction
nmap <silent> <Leader>mc :call CenterPaneToggle()<CR>

let g:loaded_center_pane = 1
