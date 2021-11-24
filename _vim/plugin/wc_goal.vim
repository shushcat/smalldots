" Set a wordcount goal.

function! WCGoal(count)
	if a:count != 0
		let b:wc_orig = wordcount()["words"]
		let b:wc_goal = a:count + b:wc_orig
	endif
	if exists('b:wc_goal')
		redraw | echo 'Goal:' b:wc_goal - wordcount()["words"] 'words.'
	endif
endfunction
command! -nargs=1 WCGoal call WCGoal(<f-args>)
autocmd InsertEnter * call WCGoal(0)
autocmd InsertLeave * call WCGoal(0)
autocmd TextChanged * call WCGoal(0)
autocmd BufEnter * call WCGoal(0)
