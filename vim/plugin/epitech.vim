function Epi_Header_Insert()
    if (expand("%:t") == 'Makefile')
        call inputsave()
        echo 'C++ Makefile [Y/n]: '
        let res = nr2char(getchar())
        call inputrestore()

        if (res == 'n')
            0r ~/.vim/skel/epi_make_c.tpl
        else
            0r ~/.vim/skel/epi_make_cpp.tpl
        endif
    elseif (expand("%:t") == 'main.cpp')
        0r ~/.vim/skel/epi_main_cpp.tpl
    elseif (expand("%:t") == 'main.c')
        0r ~/.vim/skel/epi_main.tpl
    else
        0r ~/.vim/skel/epi_%:e.tpl
    endif

    call SetHeader()
    call UpdateHeaderDate()
    normal G
    normal dd
    let save_cursor = getpos(".")
    let save_cursor[1] = 15
    call setpos(".", save_cursor)
endfunction

function Epi_CppHeader_Insert()
    0r ~/.vim/skel/epi_cpph.tpl
    call SetHeader()
    call UpdateHeaderDate()
    normal G
    normal dd
    let save_cursor = getpos(".")
    let save_cursor[1] = 10
    call setpos(".", save_cursor)

endfunction
