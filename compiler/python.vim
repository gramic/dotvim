if exists("current_compiler")
	finish
endif
let current_compiler = "python"

if exists(":CompilerSet") != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
CompilerSet makeprg=python\ -m\ unittest\ discover
