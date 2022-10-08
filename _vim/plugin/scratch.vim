function! EditScratchFile()
	silent! edit ~/notes/scratch
	silent! cd %:p:h
	silent! pwd
endfunction

nnoremap <C-End> :call EditScratchFile()<CR>
