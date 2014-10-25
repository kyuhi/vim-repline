if exists( 'g:loaded_repline' )
    finish
endif

command! -complete=function -nargs=+ -range=0 Repline
    \ call repline#replace_lines( <count>, <line1>, <line2>, <f-args> )

let g:loaded_repline = 1
