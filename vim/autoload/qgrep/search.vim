function! qgrep#search#init(state)
    if qgrep#utils#syntax()
        syntax match QgrepSearchPath "^.\{-}\ze:\d\+:" nextgroup=QgrepSearchLine
        syntax match QgrepSearchLine ":\zs\d\+\ze:"

        highlight default link QgrepSearchPath Directory
        highlight default link QgrepSearchLine LineNr
    endif
endfunction

function! qgrep#search#parseInput(state, input)
    return a:input
endfunction

function! qgrep#search#getResults(state, pattern)
    return qgrep#execute(['search', g:qgrep.project, 'L'.a:state.limit, a:pattern])
endfunction

function! qgrep#search#formatResults(state, results)
    return a:results
endfunction

function! qgrep#search#acceptResult(state, input, result, ...)
    let res = matchlist(a:result, '^\(.\{-}\):\(\d\+\):')

    if !empty(res)
        call qgrep#utils#gotoFile(res[1], a:0 ? a:1 : g:qgrep.switchbuf, ':'.res[2])
    endif
endfunction
