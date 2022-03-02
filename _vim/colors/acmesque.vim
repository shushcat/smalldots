set background=dark
highlight clear 

let g:colors_name = 'acmesque'
if exists('syntax_on')
  syntax reset
endif

" black #080808 232
" blue #e6ffff 195
" red #ffe6e6 224 

highlight! Normal guibg=#ffffea guifg=#080808 ctermbg=230 ctermfg=232 

highlight! Comment guibg=bg guifg=#303030 gui=italic ctermbg=bg ctermfg=236 cterm=italic
highlight! Conceal guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE
highlight! Constant guibg=bg guifg=#101010 gui=bold ctermbg=bg ctermfg=233 cterm=italic
highlight! CursorLine guibg=#ffffca guifg=fg ctermbg=230 ctermfg=fg
highlight! Directory guibg=bg guifg=fg gui=bold ctermbg=bg ctermfg=fg cterm=bold
highlight! FoldColumn guibg=#fcfcce guifg=fg ctermbg=229 ctermfg=fg
highlight! Folded guibg=#cccc7c guifg=fg gui=italic ctermbg=187 ctermfg=fg cterm=italic
highlight! Identifier guibg=bg guifg=fg gui=bold ctermbg=bg ctermfg=fg cterm=bold
highlight! LineNr guibg=bg guifg=#505050 gui=italic ctermbg=bg ctermfg=239 cterm=italic
highlight! NonText guibg=bg guifg=#ffffea ctermbg=bg ctermfg=230
highlight! PreProc guibg=bg guifg=fg gui=bold ctermbg=bg ctermfg=fg cterm=bold
highlight! Special guibg=bg guifg=fg gui=bold ctermbg=bg ctermfg=fg cterm=bold
highlight! SpecialKey guibg=bg guifg=fg gui=bold ctermbg=bg ctermfg=fg cterm=bold
highlight! Statement guibg=bg guifg=fg gui=italic ctermbg=bg ctermfg=fg cterm=italic
highlight! StatusLine guibg=#e6ffff guifg=#080808 gui=NONE ctermbg=195 ctermfg=232 cterm=NONE
highlight! StatusLineNC guibg=#e6ffff guifg=#080808 gui=NONE ctermbg=194 ctermfg=232 cterm=NONE
highlight! Type guibg=bg guifg=fg gui=bold ctermbg=bg ctermfg=fg cterm=bold
highlight! VertSplit guibg=#ffffea guifg=#080808 gui=NONE ctermbg=159 ctermfg=232 cterm=NONE
highlight! Visual guibg=#eaed8d guifg=fg ctermbg=185 ctermfg=fg
highlight! WarningMsg guibg=#ffe6e6 guifg=fg gui=bold ctermbg=224 ctermfg=fg cterm=bold
highlight! WildMenu guibg=#080808 guifg=#e6ffff gui=NONE ctermbg=black ctermfg=159 cterm=NONE

highlight! link ErrorMsg WarningMsg
highlight! link IncSearch Search
highlight! link MoreMsg Comment
highlight! link Pmenu StatusLine
highlight! link PmenuSel Visual
highlight! link Question Comment
highlight! link Search Visual
highlight! link Title Directory
highlight! link Todo Search
highlight! link vimFunction Identifier
highlight! link VisualNOS Visual

let g:colors_name = "acmesque"
