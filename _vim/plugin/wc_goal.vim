" WCGoal Set a wordcount goal.

function! UpdateWCGoalPopup(remaining)
	let l:report_str = "Goal: " . string(a:remaining) . " words."
	let b:wc_goal_pop_id = popup_create(l:report_str, #{
		\ pos: 'topright',
		\ line: 1,
		\ col: &columns,
		\ })
endfunction

function! RaiseWCGoalPopup()
	if exists('b:wc_goal')
		call UpdateWCGoalPopup(b:wc_goal - wordcount()["words"])
	endif
endfunction

function! HideWCGoalPopup()
		if exists('b:wc_goal_pop_id')
			call popup_close(b:wc_goal_pop_id)
		endif
endfunction

function! WCGoal(count)
	if a:count > 0
		let b:wc_orig = wordcount()["words"]
		let b:wc_goal = a:count + b:wc_orig
	elseif a:count < 0
		let b:wc_goal = b:wc_goal + a:count
	endif
	if exists('b:wc_goal')
		let l:remaining = b:wc_goal - wordcount()["words"]
		call HideWCGoalPopup()
		if l:remaining > 0
			call UpdateWCGoalPopup(l:remaining)
		else
			unlet b:wc_goal
		endif
	endif
endfunction

command! -nargs=1 WCGoal call WCGoal(<f-args>)
autocmd CursorHoldI * call WCGoal(0)
autocmd CursorHold * call WCGoal(0)

autocmd BufEnter * call RaiseWCGoalPopup()
autocmd BufLeave * call HideWCGoalPopup()
