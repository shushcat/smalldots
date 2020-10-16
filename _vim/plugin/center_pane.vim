"TODO Set highlight colors to hide elements in split panes.
let s:foldcolumn_default = &foldcolumn
let s:laststatus_default = &laststatus
let s:numberwidth_default = &numberwidth
let s:ruler_default = &ruler
let s:tabline_default = &tabline
function! CenterPaneToggle()
  let l:name='_center_pane_pad_'
  hi VertSplit guifg=bg guibg=NONE gui=NONE
  set noequalalways
  if bufwinnr(l:name) > 0
    wincmd o
    execute 'set foldcolumn=' . s:foldcolumn_default
    let &laststatus = s:laststatus_default
    execute 'set numberwidth=' . s:numberwidth_default
    let &ruler = s:ruler_default
    execute 'set tabline=' . s:tabline_default
  else
    set foldcolumn=0 laststatus=0 numberwidth=1 noruler showtabline=0
    let l:width = &columns / 7
    execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted\ nonumber' l:name | wincmd p
    execute 'botright' l:width . 'vsplit +setlocal\ nobuflisted\ nonumber' l:name | wincmd p
    execute "redraw!"
  endif
endfunction
nmap <silent> <Leader>mc :call CenterPaneToggle()<CR>
