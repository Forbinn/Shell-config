scriptencoding utf-8
set fileencoding=utf-8

set nocompatible
set backspace=2
syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set cinoptions=g-1

filetype plugin indent on

" Colorscheme
set t_Co=256
colorscheme busybee

set list
set listchars=tab:»\ 
set number
set showcmd
set mouse=a
set cursorline
set nobackup
set nowritebackup
set noswapfile
set noremap
set ofu=syntaxcomplete#Complete
set completeopt="menu"

" Doxygen comment
let g:load_doxygen_syntax=1

" mapleader variable is for <Leader> variable in mapping key
let mapleader="_"

runtime ftplugin/man.vim

highlight ExtraWhitespaces  ctermbg=red guibg=red
highlight ExtraCaractere    ctermbg=124 guibg=#A00000

function! Handle_Spaces()
    match ExtraWhitespaces /\s\+$/
    "2match ExtraCaractere  /\%81v.\+/
endfunction

au BufNewFile {*.{c,cpp,h,hh,hpp},Makefile} call Epi_Header_Insert()
au BufWritePre {*.{c,cpp,h,hh,hpp},Makefile} call UpdateHeaderDate()
au BufWinEnter,BufNew {*} call Handle_Spaces()
au BufRead,BufNewFile {*.ino} set filetype=c

" Some useful shortcut
map <special> <F3> <esc>ggvG=<CR>
map <special> <F4> <esc>:set relativenumber<CR>
map <special> <F5> <esc>:set norelativenumber<CR>
map <special> <F6> <esc>ggvGd:call Epi_CppHeader_Insert()<CR>
map <special> <F7> <esc>:Ack <cword><CR>

" Man shortcut
nmap K :Man <cword><CR>
nmap é :Man 2 <cword><CR>
nmap " :Man 3 <cword><CR>
nmap è :Man 7 <cword><CR>

" Switch panel shortcut
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

imap <C-@> <C-N>
