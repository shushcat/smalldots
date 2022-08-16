function! EditScratchFile()
	silent! edit ~/notes/scratch
	silent! cd %:p:h
	silent! pwd
endfunction

nnoremap <Leader>s :call EditScratchFile()<CR>
nnoremap <C-End> :call EditScratchFile()<CR>
