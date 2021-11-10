let s:foldcolumn_default = &foldcolumn
let s:laststatus_default = &laststatus
let s:number_default = &number
let s:numberwidth_default = &numberwidth
let s:ruler_default = &ruler
let s:tabline_default = &tabline
let s:guioptions_default = &guioptions
let s:guicursor_default = &guicursor

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

function! CenterPaneToggle()
  let l:name='_center_pane_pad_'
	call s:set_colors()
  set noequalalways
  if bufwinnr(l:name) > 0
		let l:pad_bufnr = bufnr("_center_pane_pad_")
		exec "bwipeout " . l:pad_bufnr
    silent wincmd o
    execute 'set foldcolumn=' . s:foldcolumn_default
    let &laststatus = s:laststatus_default
		if s:number_default == 1
			execute 'set number'
		endif
    execute 'set numberwidth=' . s:numberwidth_default
    let &ruler = s:ruler_default
    execute 'set tabline=' . s:tabline_default
		execute 'set guioptions=' . s:guioptions_default
		execute 'set guicursor=' . s:guicursor_default
		execute 'colorscheme' g:colors_name
  else
    set foldcolumn=0 laststatus=0 numberwidth=1 nonumber noruler showtabline=0
		set guioptions-=rL
		set guicursor+=a:blinkon0
    let l:width = &columns / 3
    execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted\ nonumber' l:name | wincmd p
    execute 'botright' l:width . 'vsplit +setlocal\ nobuflisted\ nonumber' l:name | wincmd p
    execute "redraw!"
  endif
endfunction
nmap <silent> <Leader>mc :call CenterPaneToggle()<CR>
