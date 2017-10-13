" Compiler: closure
" Last Change: 2017-10-13

if exists("current_compiler")
  finish
endif
let current_compiler = "closure"

if exists(":CompilerSet") != 2  " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=bazel

CompilerSet errorformat=
      \%-Z%p^,
      \%+C%.%#,
      \%E%f:%l:\ ERROR\ -\ %m,
      \%f:%l:\ %tARNING\ lintChecks\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:
