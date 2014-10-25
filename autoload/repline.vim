let s:save_cpo = &cpo
set cpo&vim

func! repline#replace_lines( is_range, start_line_num, end_line_num, ... )
    " how to detect whether [range] is given at user command.
    " http://d.hatena.ne.jp/thinca/20110810/1312913305
    let func = a:000[ 0 ]
    if a:is_range
        for line_num in range( a:start_line_num, a:end_line_num )
            call s:replace_applied_line( line_num, func, a:000[1:] )
        endfor
    else
        call s:replace_applied_line( line( '.' ), func, a:000[1:] )
    endif
endfunc


" ==================================
" sample functions to replace lines
" ==================================
func! repline#strip( string )
    return repline#lstrip( repline#rstrip( a:string ) )
endfunc

func! repline#lstrip( string )
    return substitute( a:string, '^\s\+', '', '' )
endfunc

func! repline#rstrip( string )
    return substitute( a:string, '\s\+$', '', '' )
endfunc

func! repline#concat( string1, string2 )
    return a:string1 . a:string2
endfunc


" ======================
" script local functions
" ======================
func! s:replace_applied_line( line_num, func, func_args )
    let line = getline( a:line_num )
    let args = [ line ] + a:func_args
    let line_to_repl = call( a:func, args )
    call setline( a:line_num, line_to_repl )
endfunc

let &cpo = s:save_cpo
unlet s:save_cpo
