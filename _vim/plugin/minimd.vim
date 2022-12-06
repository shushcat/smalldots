autocmd FileType minimd nmap <Leader>ms :setlocal spell!<CR>

autocmd FileType minimd nmap <Leader>c :echo "Words: " wordcount()["words"]<CR>

autocmd FileType minimd iab <expr> ds strftime("[%Y-%m-%d]")

" Format markdown tables
autocmd FileType minimd nmap <Leader>mt vip:!sed 's/ *\| */\@\@\| /g' \| column -t -s '@@' \| sed 's/^ *//'<CR>

autocmd FileType minimd set suffixesadd=.md
