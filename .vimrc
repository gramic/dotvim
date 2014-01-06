set nocompatible " Use Vim defaults instead of 100% vi compatibility
set tabstop=2
set shiftwidth=2
set smarttab
set smartindent
set ignorecase
set smartcase
set incsearch
set expandtab

set noswapfile

set backspace=start,indent,eol  " make backspace work like 'normal' text editors

" Terminal shell settings {{{
set t_Co=256
" }}}

" undo settings {{{
set undofile
set undodir=~/.vim_runtime/undodir
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
" }}}

syntax on
set synmaxcol=1000
let g:matchparen_insert_timeout=10

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Cyrillic support {{{
set encoding=utf8
set keymap=bulgarian-phonetic
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
" }}}

" GUI settings {{{
if has('gui_win32')
  set clipboard=unnamedplus
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h10:cDEFAULT,Fixed\ 10
else
  " Since I use linux, I want this
  set clipboard=unnamedplus
endif
" }}}

set numberwidth=2

" Color colomun settings {{{
augroup ColorcolumnOnlyInInsertMode
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=81
  autocmd InsertLeave * setlocal colorcolumn=0
augroup END
" }}}

" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" Bundles: {{{
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

" My own vim settings.
"Bundle 'itchyny/lightline.vim'
"reStructuredText plugin
Bundle 'Rykka/riv.vim.git'
Bundle 'bling/vim-airline'
Bundle "indenthtml.vim"
Bundle "gmarik/vundle"
Bundle "gramic/dotvim.git"
Bundle 'EasyMotion'
Bundle 'Valloric/MatchTagAlways.git'
Bundle 'Valloric/YouCompleteMe.git'
Bundle 'scrooloose/syntastic.git'
Bundle 'dbext.vim'
" cmdcomplition by pressing <c-l> in the command line
Bundle 'paradigm/SkyBison.git'
Bundle 'paradigm/vim-multicursor.git'
Bundle 'embear/vim-localvimrc.git'
Bundle "vim-indent-object"
Bundle "argtextobj.vim"
Bundle "Tabular"
Bundle "ctrlp.vim"
Bundle "pangloss/vim-javascript.git"
Bundle 'cs.vim'
Bundle "jelera/vim-javascript-syntax.git"
Bundle "fs111/pydoc.vim"
Bundle "L9"
Bundle "The-NERD-Commenter"
Bundle "mattn/emmet-vim.git"
Bundle "ZoomWin"
Bundle "cecutil"
Bundle 'Cpp11-Syntax-Support'
Bundle "cmake.vim"
Bundle "cmake.vim-syntax"
Bundle "tpope/vim-fugitive.git"
Bundle "tpope/vim-unimpaired"
Bundle "tpope/vim-obsession"
Bundle "tpope/vim-abolish"
Bundle "tpope/vim-characterize.git"
Bundle "tpope/vim-dispatch.git"
Bundle "mbbill/undotree"
Bundle "gitv"
Bundle "airblade/vim-gitgutter"
Bundle "google.vim"
Bundle "matchit.zip"
Bundle "repeat.vim"
Bundle "vim-addon-mw-utils"
Bundle "tlib"
" Bundle "snipmate-snippets"
Bundle 'UltiSnips'
Bundle "garbas/vim-snipmate.git"
Bundle "surround.vim"
Bundle "mattdbridges/bufkill.vim"
Bundle "nelstrom/vim-visual-star-search"
Bundle "ap/vim-css-color.git"
Bundle "vim-soy"
" Syntaxes
Bundle "jnwhiteh/vim-golang.git"
"Bundle "marijnh/tern_for_vim.git"
Bundle 'JSON.vim'
Bundle 'lighttpd-syntax'
Bundle 'nginx.vim'
" }}}

set exrc
let g:localvimrc_name=".stanimir.vimrc"
let g:localvimrc_sandbox=0

" Color scheme settings {{{
filetype off
Bundle "altercation/vim-colors-solarized"
Bundle 'chriskempson/base16-vim'


filetype plugin indent on
set background=light
" let g:solarized_termtrans=1
let g:solarized_termcolors=256
let base16colorspace=256  " Access colors present in 256 colorspace
"silent! colorscheme base16-tomorrow
silent! colorscheme solarized
"set background=dark
let g:airline_section_a='[%{bufnr("%")}]'
let g:airline_left_sep=''
let g:airline_right_sep=''
" }}}

" Fugitive group. {{{
augroup fugitivegroup
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}}

" Status line {{{
set laststatus=2
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path
set statusline+=%=                        " seperate between right-left-aligned
set statusline+=%{fugitive#statusline()}\ " git branch name
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10((%l/%L\ %c)%)\        " line and column
set statusline+=%P                        " percentage of file
" }}}

" Menu completions {{{
set wildmode=full wildmenu                 " Command-line tab completion
set infercase                              " AutoComplete in Vim
set completeopt=longest,menu,menuone,preview
set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db,*.swc
" }}}

" Gui options {{{
:set guioptions=ai  "remove all gui options except select copy buffer and icon
" }}}

" Movements {{{
" have the h and l cursor keys wrap between lines
" (like </space><space> and <bkspc> do by default),
" and ~ convert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]
" }}}

" BufKill {{{
" Disable key mappings.
let g:BufKillCreateMappings = 0
" }}}

" Emmet ZenCoding bundle mappings {{{
let g:user_emmet_leader_key = "<leader>y"
" }}}

" UltiSnips bundle mappings {{{
let g:UltiSnipsExpandTrigger = "<leader>ss"
let g:UltiSnipsJumpForwardTrigger = "<leader>sn"
let g:UltiSnipsJumpBackwardTrigger = "<leader>sp"
" }}}

" Gitv configuration {{{
let g:Gitv_TruncateCommitSubjects = 1
" }}}

" Unite bundle mappings {{{
"let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>y :Unite history/yank<cr>
" }}}

" SkyBison bundle mappings {{{
cnoremap <c-l> <c-r>=SkyBison("")<cr><cr>
let g:skybison_fuzz=1
" }}}

" MultiCursor bundle mappings {{{
let g:multicursor_quit = "<localleader>qq"
nnoremap <localleader>qp :<c-u>call MultiCursorPlaceCursor()<cr>
nnoremap <localleader>qm :<c-u>call MultiCursorManual()<cr>
nnoremap <localleader>qr :<c-u>call MultiCursorRemoveCursors()<cr>
nnoremap <localleader>qr :<c-u>call MultiCursorRemoveCursors()<cr>
xnoremap <localleader>qv :<c-u>call MultiCursorVisual()<cr>
nnoremap <localleader>qs :<c-u>call MultiCursorSearch('')<cr>
" }}}

" dbext {{{
let g:dbext_default_profile_sqlite_for_wfm = 'type=SQLITE:dbname=/home/zoneprojects/work/zone_projects/projects/zplanning/ProjectManagerWebSite/wfm.db'
" }}}

" YouCompleteMe {{{
" let g:ycm_key_invoke_completion = '<C-Space>'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" MultiCursor bundle mappings {{{
let g:multicursor_quit = "<localleader>qq"
nnoremap <localleader>qp :<c-u>call MultiCursorPlaceCursor()<cr>
nnoremap <localleader>qm :<c-u>call MultiCursorManual()<cr>
nnoremap <localleader>qr :<c-u>call MultiCursorRemoveCursors()<cr>
nnoremap <localleader>qr :<c-u>call MultiCursorRemoveCursors()<cr>
xnoremap <localleader>qv :<c-u>call MultiCursorVisual()<cr>
nnoremap <localleader>qs :<c-u>call MultiCursorSearch('')<cr>
" }}}

" Yankstack {{{
" The yankstack mappings need to happen before I define my own.
" call yankstack#setup()
" nmap <c-p> <Plug>yankstack_substitute_older_paste
" nmap <c-n> <Plug>yankstack_substitute_newer_paste
" }}}

" gitgutter {{{
highlight clear SignColumn
let g:gitgutter_enabled = 0
" }}}

" General mappings {{{
"map copy to end of line
nnoremap Y y$
"Make the single quote work like a backtick
nnoremap ' `
" <C-l> redraws the screen, disable search term highlighting (don't switch it
" off) and switches of the list view option
nnoremap <silent> <C-l> :nohlsearch <bar> set nolist<CR><C-l>

if has("gui_running") && has("gui_win32")
    " use alt-space for window options
    nnoremap <m-space> :simalt~<CR>
endif
map ' `

" Save files with sudo rights if you forgot
:command! W w !sudo tee % > /dev/null

"wildmenu that can be used like :e <C-D>
set wildmenu


" Javascript autocommands {{{
" our style is curly brace at the end of the function signature
" Java autocommands {{{
augroup javascriptgroup
  au!
  autocmd BufNewFile,BufRead *.js map [[ ?function(.*)\ {$<CR>
  autocmd BufNewFile,BufRead *.js map ]] /^};$<CR>
  " Google js lint this file
  autocmd BufNewFile,BufRead *.js map-local <C-j> :!gjslint --strict %<CR>
augroup END
" }}}

"turn omni completion on
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"set tags+=~/.vim/closuretags
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimMavenPomClasspathUpdate = 0
let g:EclimJavascriptValidate = 0

" Java autocommands {{{
augroup filetype_java
  au!
  " use this to drive eclim auto complition to YCM. Remove after the above
  " is available in the next version of eclim.
  autocmd Filetype java setlocal omnifunc=eclim#java#complete#CodeComplete
augroup END
" }}}

"Doxygen Toolkit settings for javascript comments {{{
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_startCommentTag = "/** "
let g:DoxygenToolkit_startCommentBlock = "/* "
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre = "@param {} "
let g:DoxygenToolkit_interCommentTag=" * "
let g:DoxygenToolkit_endCommentTag = " */"
let g:DoxygenToolkit_endCommentBlock = " */"
" }}}


" Prevent various Vim features from keeping the contents of pass(1) password {{{
" files (or any other purely temporary files) in plaintext on the system.
"
" Either append this to the end of your .vimrc, or install it as a plugin with
" a plugin manager like Tim Pope's Pathogen.
"
" Author: Tom Ryder <tom@sanctum.geek.nz>
"

" Don't backup files in temp directories or shm
set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*

" Don't keep swap files in temp directories or shm
augroup swapskip
  autocmd!
  silent! autocmd BufNewFile,BufReadPre
      \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
      \ setlocal noswapfile
augroup END

" Don't keep undo files in temp directories or shm
if has('persistent_undo') && has('autocmd')
    augroup undoskip
        autocmd!
        silent! autocmd BufWritePre
            \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
            \ setlocal noundofile
    augroup END
endif
" }}}

"Error format
"autocmd FileType json set errorformat=%E%f:\ %m\ at\ line\ %l,%-G%.%#
set errorformat+=%W%f:%l:\ WARNING\ -\ %m,%C,%C%p^
set errorformat+=%E%f:%l:\ ERROR\ -\ %m,%C,%C%p^
" this is to not open empty file. tip from here http://goo.gl/5pgIK
set errorformat^=%-GIn\ file\ included\ %.%#

" Soy files to be syntax html like
":au! BufNewFile,BufRead *.soy set filetype=html

" Developing Javascript mappings
"set makeprg=make\ -C\ ./build
"nnoremap <localleader>bb :make! -j 12<CR>
"nnoremap <localleader>bt :make! testall<CR>
"nmap <LocalLeader>bB <Leader>bb:!tmux send-keys -t :.1 C-c ENTER Up ENTER\<CR><CR>
"nnoremap <localleader>br :set makeprg=make\ -C\ ./build_release<CR><Bar>:!cd ./build_release && CC=/usr/local/bin/clang CXX=/usr/local/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Release -DJDEBUG=OFF ..<CR>
"nnoremap <localleader>bd :set makeprg=make\ -C\ ./build<CR><Bar>:!cd ./build && CC=/usr/local/bin/clang CXX=/usr/local/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Debug -DJDEBUG=ON ..<CR>

" convert json property to exported closure compiler name
noremap <leader>j bi["<Esc>ea"]<Esc>


" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" If no errors, it closes any open cwindow.
:command! -nargs=* Make make! <args>

" CtrlP mappings
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 2 " don't manage current directory
let g:ctrlp_root_markers = ['CMakeLists\.txt']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|build$\|build_release$\|build_debug$\|third_parties\|target$',
  \ }
let g:ctrlp_map = '<localleader>ff'
nnoremap <localleader>fm :CtrlPMRU<CR>
nnoremap <localleader>fc :CtrlPCurWD<CR>
let g:ctrlp_by_filename = 1 " search by filename (not full path) as default.
let g:ctrlp_dotfiles = 0 " do not search inside dot files and dirs.

" Limit popup menu height
set pumheight=15

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

if !exists("lint_autocommand_loaded")
  let lint_autocommand_loaded = 1
  au FileType json setlocal equalprg=json_reformat
  au BufRead *.json set filetype=json
  au FileType python setlocal tabstop=4 shiftwidth=4 foldmethod=indent
  au BufRead nginx.conf set filetype=nginx
  au BufRead lighttpd.conf set filetype=lighttpd

  au BufRead *.cpp,*.c,*.cc,*.hpp,*.h noremap <buffer> <Leader>i :call ClangFormat()<CR>
  au BufRead *.cpp,*.c,*.cc,*.hpp,*.h noremap <buffer> <Leader>bt :call CppRunTests("")<CR>
  au BufRead *.js noremap <buffer> <Leader>l :call Jslint()<CR>
endif

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Clean up trailing white spaces.
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" Format whole file.
nmap _= :call Preserve("normal gg=G")<CR>

function! CppRunTests(args)
  let l:old_makeprg = &makeprg
  set makeprg=make\ -C\ build\ testall
  exec 'make'
  let &makeprg=l:old_makeprg
endfunction

function! ClangFormat()
  :!clang-format -i -style=Google %
endfunction

function! ClangModernize()
  :!clang-modernize -style=Google -format -use-nullptr -add-override -override-macros -p=build/ %
endfunction

function! Jslint()
  let l:old_makeprg = &makeprg
  set makeprg=gjslint\ %
  let l:old_errorformat = &errorformat
  set errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyle%s,%-Gscript\ can\ %s,%-G
  make
  let &makeprg=l:old_makeprg
  set errorformat=&l:old_errorformat
endfunction
