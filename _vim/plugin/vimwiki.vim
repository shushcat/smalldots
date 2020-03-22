let g:vimwiki_ext2syntax = {'.wiki': 'default'}
let g:vimwiki_folding='expr'
let g:vimwiki_global_ext = 0
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_html_header_numbering = 2
let g:vimwiki_menu=''

let wiki = {}
let wiki.syntax = 'default'
let wiki.diary_rel_path = ".diary"
let wiki.ext = '.wiki'
let wiki.path = "~/Sync/wiki/"
let wiki.path_html = "~/Sync/wiki/html/"
let wiki.auto_export = 1
let wiki.template_path = "~/Sync/wiki/html/templates/"
let wiki.index = "index"

let g:vimwiki_list = [wiki]
