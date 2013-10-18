" Compiler:	cordova
" Last Change:	2013-10-17

if exists("current_compiler")
  finish
endif
let current_compiler = "cordova"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=cordova\ prepare


" Use each file and line of Tracebacks (to see and step through the code executing).
" Include failed toplevel doctest example.
" Ignore big star lines from doctests.
" Ignore most of doctest summary. x2
CompilerSet errorformat=
      \%A%\\s%#File\ \"%f\"\\,\ line\ %l\\,\ in%.%#,
      \%+CFailed\ example:%.%#,
      \%Z%*\\s\ \ \ %m,
      \%-G*%\\{70%\\},
      \%-G%*\\d\ items\ had\ failures:,
      \%-G%*\\s%*\\d\ of%*\\s%*\\d\ in%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:
