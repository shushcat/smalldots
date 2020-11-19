if executable("fzf")
	if filereadable("/usr/share/doc/fzf/examples/fzf.vim")
		source /usr/share/doc/fzf/examples/fzf.vim
	endif
	nnoremap <Leader>b :Buffers<CR>
	nnoremap <Leader>f :Files<CR>
	nnoremap <Leader>g :Rg<Space>
	nnoremap <Leader>l :BLines<CR>
	nnoremap <Leader>mh :BLines ^# <CR>
endif

