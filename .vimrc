"to start neovim in true color support
"TERM=xterm-256colors NVIM_TUI_ENABLE_TRUE_COLOR=1 SHELL=/bin/bash
set nocompatible " Use Vim defaults instead of 100% vi compatibility
set tabstop=2
set shiftwidth=2
set smarttab
set smartindent
set ignorecase
set smartcase
set incsearch
set nohlsearch
set expandtab
set autoread
if has('mouse') | set mouse= | endif
if has('termguicolors') | set termguicolors | endif
if exists('&inccommand') | set inccommand=nosplit | endif

set t_8f=[38;2;%lu;%lu;%lum
set t_8b=[48;2;%lu;%lu;%lum

set noswapfile
set suffixes-=.h " remove header files from lower priority directory sort

set backspace=start,indent,eol  " make backspace work like 'normal' text editors

" Terminal shell settings {{{
set t_Co=256
" }}}

" undo settings {{{
set undofile
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

" settings {{{
" Since I use linux, I want this
set clipboard=unnamedplus
set numberwidth=2
" let mapleader=" "
" }}}

" Color colomun settings {{{
augroup ColorcolumnOnlyInInsertMode
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=81
  autocmd InsertLeave * setlocal colorcolumn=0
augroup END
" }}}

" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" Plugins: {{{                                                                                                                                                                                                                                                               [347/407]
"set rtp+=$HOME/.vim/bundle/vundle/
"call vundle#rc()

"Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" My own vim settings.
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'jreybert/vimagit'
Plug 'bazelbuild/vim-bazel'
Plug 'bazelbuild/vim-ft-bzl'
"Plug 'machakann/vim-highlightedyank'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'justinmk/vim-dirvish'
Plug 'https://github.com/benekastah/neomake.git'
Plug 'critiqjo/lldb.nvim'
"Plugin 'itchyny/lightline.vim'
Plug 'guns/xterm-color-table.vim'
"Plugin 'itchyny/calendar.vim'
"reStructuredText plugin
"Plugin 'Rykka/riv.vim'
"Plug 'indenthtml.vim'
Plug 'gramic/dotvim'
"Plug 'zoneprojects/dotvimprivate'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'argtextobj.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'jpetrie/vim-counterpoint'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-dadbod'
Plug 'jonathanfilip/vim-dbext'
"Plug 'cmake.vim'
"Plug 'cmake.vim-syntax'
Plug 'gcmt/taboo.vim'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-dispatch'
Plug 'mbbill/undotree'
Plug 'gregsexton/gitv'
Plug 'benjifisher/matchit.zip'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'nelstrom/vim-visual-star-search'
Plug 'ap/vim-css-color'
Plug 'duganchen/vim-soy'
" Syntaxes
Plug 'google/vim-jsonnet'

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'
"Plugin 'sjl/vitality.vim'

set exrc
let g:localvimrc_name=".stanimir.vimrc"
let g:localvimrc_sandbox=0

" Color scheme settings {{{
filetype off
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender'
Plug 'lifepillar/vim-solarized8'
call plug#end()
" }}}


filetype plugin indent on
let g:highlightedyank_highlight_duration = 100
set background=light
" let g:solarized_termtrans=1
let g:solarized_termcolors=256
let base16colorspace=256  " Access colors present in 256 colorspace
"silent! colorscheme base16-tomorrow
"silent! colorscheme solarized
silent! colorscheme gruvbox
"silent! colorscheme tender
set background=dark
" }}}

" Calender group. {{{
augroup fugitivegroup
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
  let g:calendar_first_day = 'monday'
augroup END
" }}}

" Vim commentary group. {{{
augroup vim_commentary
  autocmd FileType cpp set commentstring=//\ %s
augroup END
" }}}

" Github-issues group. {{{
let g:github_access_token = "32a5c2ba3eb003cbe99385ec400495210f38fc59"
" }}}

" Fugitive group. {{{
augroup fugitivegroup
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}}


" Taboo group. {{{
augroup taboogroup
let g:taboo_tab_format = " %N %P "
augroup END
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

" Gitv configuration {{{
let g:Gitv_TruncateCommitSubjects = 1
" }}}

" Unite Plugin mappings {{{
"let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>y :Unite history/yank<cr>
" }}}

" Generic mappings {{{
if exists(':tnoremap')
tnoremap <esc> <c-\><c-n>
endif
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
" }}}

" YouCompleteMe {{{
" let g:ycm_key_invoke_completion = '<C-Space>'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" gitgutter {{{
highlight clear SignColumn
let g:gitgutter_enabled = 0
" }}}

" folding {{{
" Enable bazel folding
let g:ft_bzl_fold = 1
" }}}

" codefmt {{{
if exists("*glaive#Install")
  call glaive#Install()
  " Optional: Enable codefmt's default mappings on the <Leader>= prefix.
  Glaive codefmt plugin[mappings]
  Glaive codefmt clang_format_style=Google
endif
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

" Error formats {{{
" }}}

" refasterjs errorformats {{{
" New Content: "value.getContent().getContent()", Replacements for file: /app/app/client/shared/soyutils_usegoog.js
" Start position: 38790
" Length: 21
set errorformat=%ANew\ Content:\ %m\ Replacements\ for\ file:\ %f
set errorformat+=%CStart\ position:
set errorformat+=%Z%.%#Length:\ $C
"set errorformat=%ANew\ Content:\ %m\ Replacements\ for\ file:\ %f
" }}}

" this is to not open empty file. tip from here http://goo.gl/5pgIK
set errorformat^=%-GIn\ file\ included\ %.%#

" all errorformats
set errorformat=%E%.%#:\ %f:%l:\ ERROR\ -\ %m,%C,%Z%p^,%W%.%#:\ %f:%l:\ WARNING\ -\ %m,%C,%Z%p^
set errorformat+=%E%f:%l:\ ERROR\ -\ %m,%C,%Z%p^,%W%f:%l:\ WARNING\ -\ %m,%C,%Z%p^
" *** No rule to make target `/app/app/client/page/schedulerenderer.soy', needed by `/app/app/client/soy_js_en/scheduleplace_soy_en.js'.  Stop.
set errorformat+=%A%.%#***\ %m\ `%f'%.%#
" }}}


" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" If no errors, it closes any open cwindow.
:command! -nargs=* Make make! <args>

" CtrlP mappings
let g:fzf_command_prefix = "Fzf"
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_working_path_mode = 2 " don't manage current directory
let g:ctrlp_root_markers = ['CMakeLists\.txt']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules$\|bazel-app$\|bazel-bin$\|bazel-genfiles$\|bazel-out$\|build$\|build_release$\|build_debug$\|third_parties\|target$',
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

  au BufRead *.cpp,*.c,*.cc,*.hpp,*.h noremap <buffer> <Leader>bt :call CppRunTests("")<CR>
  au BufRead *.js noremap <buffer> <Leader>l :call Jslint()<CR>
endif

function! SimpleStatusLine()
    set laststatus=0
    set statusline=
    set statusline+=%f                        " relative path
    set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
endfunction

function! ComplicatedStatusLine()
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
endfunction

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

set makeprg=bazel
