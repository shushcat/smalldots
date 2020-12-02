"TODO Set highlight colors to hide elements in split panes.
let s:foldcolumn_default = &foldcolumn
let s:laststatus_default = &laststatus
let s:number_default = &number
let s:numberwidth_default = &numberwidth
let s:ruler_default = &ruler
let s:tabline_default = &tabline
let s:bg_color = synIDattr(hlID("Normal"), "bg")
" let s:vertsplit_color = exec "hi VertSplit"
" synIDtrans?
function! CenterPaneToggle()
  let l:name='_center_pane_pad_'
  hi VertSplit ctermfg=black
  hi NonText guifg=black ctermfg=black
  hi EndOfBuffer guifg=black ctermfg=black
  set noequalalways
  if bufwinnr(l:name) > 0
		let l:pad_bufnr = bufnr("_center_pane_pad_")
		" exec "bdelete " . l:pad_bufnr
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
  else
    set foldcolumn=0 laststatus=0 numberwidth=1 nonumber noruler showtabline=0
    let l:width = &columns / 7
    execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted\ nonumber' l:name | wincmd p
    execute 'botright' l:width . 'vsplit +setlocal\ nobuflisted\ nonumber' l:name | wincmd p
    execute "redraw!"
  endif
endfunction
nmap <silent> <Leader>mc :call CenterPaneToggle()<CR>
