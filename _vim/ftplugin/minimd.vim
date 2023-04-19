set suffixesadd=.md
setlocal shiftwidth=4 tabstop=4

nmap <Leader>ms :setlocal spell!<CR>
nmap <Leader>c :echo "Words: " wordcount()["words"]<CR>
iab <expr> ds strftime("[%Y-%m-%d]")

" Format markdown tables
autocmd FileType minimd nmap <Leader>mt vip:!sed 's/ *\| */\@\@\| /g' \| column -t -s '@@' \| sed 's/^ *//'<CR>
