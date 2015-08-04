function Header_Insert()
    if (expand("%:t") == 'Makefile')
        call inputsave()
        echo 'C++ Makefile [Y/n]: '
        let res = nr2char(getchar())
        call inputrestore()

        if (res == 'n')
            0r ~/.vim/skel/make_c.tpl
        else
            0r ~/.vim/skel/make_cpp.tpl
        endif
    elseif expand("%:e") == 'c' || expand("%:e") == 'cpp'
        0r ~/.vim/skel/c.tpl
    else
        0r ~/.vim/skel/h.tpl
    endif

    call SetHeader()
    normal G
    normal dd
    let save_cursor = getpos(".")
    let save_cursor[1] = 15
    call setpos(".", save_cursor)
endfunction

function SetHeader()
  let save_cursor  = getpos(".")
  execute "silent %s,@@HDR_NAME@@," . toupper(substitute(expand("%:t"),'\..*$', "", "ge")) . ",ge"
  execute "%s,@@COPYRIGHT@@," . "Copyright " . strftime('%Y') . " " . $USERNAME . ",ge"
  execute "%s,@@AUTHOR@@," . $NAME . ",ge"
  execute "%s,@@AUTHORMAIL@@," . tolower($MAILADDR) . ",ge"
  call setpos('.', save_cursor)
endfunction

function Handle_Spaces()
    match ExtraWhitespaces /\s\+$/
    "2match ExtraCaractere  /\%81v.\+/
endfunction
