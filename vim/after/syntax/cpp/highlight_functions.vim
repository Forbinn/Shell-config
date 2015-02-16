syn match cCustomParen	"(" contains=cParen contains=cCppParen
syn match cCustomFunc	"\w\+\s*(" contains=cCustomParen
syn match cCustomScope  "::"
syn match cCustomClass  "\w\+\s*::" contains=cCustomScope

hi def link cCustomFunc	Function
hi def link cCustomClass Class

hi Function 	guifg=#7e8aa2 gui=none ctermfg=110
hi Class guifg=#7e8aa2 gui=none ctermfg=103
