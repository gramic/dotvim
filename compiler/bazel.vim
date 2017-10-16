" Compiler: bazel
" Last Change: 2017-10-13

if exists("current_compiler")
  finish
endif
let current_compiler = "bazel"

if exists(":CompilerSet") != 2  " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=bazel

CompilerSet errorformat=
      \%tRROR:\ %f:%l:%c:\ %m ,
      \%tARNING:\ %f:%l:%c:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:
