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

augroup filetype_vim
    au!
    au FileType vim setlocal foldmethod=marker
    au! BufNewFile,BufRead *.ledger set filetype=ledger
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
  set guifont=DejaVu\ Sans\ Mono:h12:b:cDEFAULT
else
  " Since I use linux, I want this
  set clipboard=unnamedplus
endif
" }}}

" color column
set colorcolumn=80
set numberwidth=2

" Match trailing whitespace, except when typing at the end of a line. {{{
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}

" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" Bundles: {{{
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

" My own vim settings.
Bundle "gmarik/vundle"
Bundle "git://github.com/gramic/dotvim.git"
Bundle "kljohann/ledger",{"rtp":"contrib/vim"}
Bundle "git://github.com/michaeljsmith/vim-indent-object.git"
Bundle "git://github.com/vim-scripts/argtextobj.vim.git"
Bundle "kana/vim-fakeclip.git"
"Bundle "vundle.vim"
Bundle "Tabular"
Bundle "CSApprox"
" Bundle "Color-Sampler-Pack"
" Bundle "FuzzyFinder"
Bundle "git://github.com/kien/ctrlp.vim.git"
Bundle "batsuev/vim-javascript.git"
Bundle "jelera/vim-javascript-syntax.git"
" Bundle "Javascript-Indentation"
Bundle "L9"
" Bundle "ScrollColors"
" Bundle "SuperTab-continued."
Bundle "The-NERD-Commenter"
Bundle "The-NERD-tree"
Bundle "YankRing.vim"
Bundle "ZenCoding.vim"
Bundle "ZoomWin"
Bundle "cecutil"
" Bundle "Rip-Rip/clang_complete.git"
" Bundle "Schmallon/clang_complete.git"
Bundle "cmake.vim"
Bundle "cmake.vim-syntax"
Bundle "fugitive.vim"
Bundle "git://github.com/gregsexton/gitv.git"
Bundle "google.vim"
Bundle "matchit.zip"
"Bundle "reload.vim"
Bundle "repeat.vim"
Bundle "matchit.zip"
Bundle "git://github.com/MarcWeber/vim-addon-mw-utils.git"
Bundle "git://github.com/tomtom/tlib_vim.git"
Bundle "git://github.com/honza/snipmate-snippets.git"
" Bundle 'UltiSnips'
Bundle "git://github.com/garbas/vim-snipmate.git"
Bundle "surround.vim"
Bundle "bufkill.vim"
Bundle "git://github.com/skammer/vim-css-color.git"
Bundle "git://github.com/duganchen/vim-soy"
" Syntaxes
Bundle "Lokaltog/vim-powerline.git"
Bundle "git://github.com/jnwhiteh/vim-golang.git"
Bundle "https://github.com/nsf/gocode",{"rtp":"vim"}
Bundle 'JSON.vim'
Bundle 'nginx.vim'
" }}}

" Color scheme settings {{{
filetype off
Bundle "altercation/vim-colors-solarized"


filetype plugin indent on
set background=light
let g:solarized_termcolors=256
colorscheme solarized
set background=light
let g:Powerline_symbols='fancy'
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
set completeopt=longest,menu,menuone
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

" General mappings {{{
"map copy to end of line
nnoremap Y y$
"Make the single quote work like a backtick
nnoremap ' `
"save with Ctrl + S
:nnoremap <C-S> :w<CR>
:inoremap <C-S> <Esc>:w<CR>
"nmap Space to PageDown and Shift Space to PageUp
:nnoremap <Space> <PageDown>
:nnoremap <S-Space> <PageUp>
" <C-l> redraws the screen, disable search term highlighting (don't switch it
" off) and switches of the list view option
nnoremap <silent> <C-l> :nohlsearch <bar> set nolist<CR><C-l>
" Search for selected text, forwards or backwards.
" (retrieved 24/2/2011 - http://vim.wikia.com/wiki/Search_for_visually_selected_text)
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

if has("gui_running") && has("gui_win32")
    " use alt-space for window options
    nnoremap <m-space> :simalt~<CR>
endif
map ' `

"map omni completion keys to Ctrl + Space
:inoremap <C-Space> <C-X><C-O>
" }}}

" Save files with sudo rights if you forgot
:command! W w !sudo tee % > /dev/null

"nmap Space to PageDown and Shift Space to PageUp
:nmap <Space> <PageDown>
:nmap <S-Space> <PageUp>

" <C-l> redraws the screen, disable search term highlighting (don't switch it
" off) and switches of the list view option
nnoremap <silent> <C-l> :nohlsearch <bar> set nolist<CR><C-l>

" Search for selected text, forwards or backwards.
" (retrieved 24/2/2011 - http://vim.wikia.com/wiki/Search_for_visually_selected_text)
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

if has("gui_running") && has("gui_win32")
    " use alt-space for window options
    nnoremap <m-space> :simalt~<CR>
endif

"map omni completion keys to Ctrl + Space
:imap <C-Space> <C-X><C-O>

"wildmenu that can be used like :e <C-D>
set wildmenu


" Html, css, refresh browser autocommands {{{
augroup refresh_browser
  au!
  autocmd BufWriteCmd *.html,*.css :call Refresh_browser()
augroup END

function! Refresh_browser()
  if &modified
    write
    " Call the line bellow to see the window number
    " !xdotool search --name "ВАТ Консулт"
    silent !xdotool key --window 60817476 ctrl+r
  endif
endfunction
" }}}

" Javascript autocommands {{{
" our style is curly brace at the end of the function signature
autocmd BufNewFile,BufRead *.js map [[ ?function(.*)\ {$<CR>
autocmd BufNewFile,BufRead *.js map ]] /^};$<CR>
" Google js lint this file
autocmd BufNewFile,BufRead *.js map-local <C-j> :!gjslint --strict %<CR>
" }}}

"turn omni completion on
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"set tags+=~/.vim/closuretags

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

"Error format
"autocmd FileType json set errorformat=%E%f:\ %m\ at\ line\ %l,%-G%.%#
set errorformat+=%W%f:%l:\ WARNING\ -\ %m,%C,%C%p^
set errorformat+=%E%f:%l:\ ERROR\ -\ %m,%C,%C%p^

" Soy files to be syntax html like
":au! BufNewFile,BufRead *.soy set filetype=html

" Developing Javascript mappings
set makeprg=make\ -C\ ./build_debug
nmap <leader>bb :make -j 4 docs_app js_target<CR>
nmap <leader>br :set makeprg=make\ -C\ ./build_release<CR><Bar>:!cd ./build_release && cmake .. -DJDEBUG=OFF<CR>
nmap <leader>bd :set makeprg=make\ -C\ ./build_debug<CR><Bar>:!cd ./build_debug && cmake .. -DJDEBUG=ON<CR>

" convert json property to exported closure compiler name
noremap <leader>j bi["<Esc>ea"]<Esc>


" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" If no errors, it closes any open cwindow.
:command! -nargs=* Make make <args>

" NERDTree
:noremap <Leader>F :NERDTreeToggle<CR>

let NERDTreeHijackNetrw=1
let NERDTreeMouseMode=1
let NERDTreeWinSize=50
let NERDTreeQuitOnOpen=1

let NERDSpaceDelims=2

" Fuzzy Finder js
" let g:fuf_coveragefile_prompt = '>js[]>'
" let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|hotel.*/|build.*/'
" noremap <Leader>f :call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns',['**/*.js','**/*.soy', '**/*.css']])<CR><BAR>:FufCoverageFile<CR>
" Fuzzy Finder cpp
" let g:fuf_coveragefile_prompt = '>cpp[]>'
" let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|build.*/'
" noremap <Leader>f :call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns',['**/*.h','**/*.hpp', '**/*.c', '**/*.cpp', '**/CMakeLists.txt']])<CR><BAR>:FufCoverageFile<CR>

" FuzzyFinder mappings
" noremap <Leader>b :FufBuffer<CR>
" let g:fuf_modesDisable=['mrucmd']
" let g:fuf_buffer_mruOrder=1
" noremap <Leader>m :FufMruFile<CR>

" CtrlP mappings
let g:ctrlp_map = '<localleader>f'
nnoremap <localleader>m :CtrlPMRU<CR>
let g:ctrlp_by_filename = 1 " search by filename (not full path) as default.
let g:ctrlp_dotfiles = 0 " do not search inside dot files and dirs.
set wildignore+=*/.hg/*,*/.svn/*   " for Linux/MacOSX
set wildignore+=*/build*/*


" Limit popup menu height
set pumheight=15

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"

" C++
" Clang settings
let g:clang_complete_auto=0
let g:clang_hl_errors=1
let g:clang_debug=1
let g:clang_use_library=1
let g:home_dir = expand("$HOME/")
let g:clang_library_path=g:home_dir."/opt/lib/"
" let g:clang_user_options="-I/".g:home_dir."/opt/clang/3.1/include"
" let g:clang_auto_user_options="-I/".g:home_dir."/opt/clang/3.1/include, .clang_complete"
let g:clang_snippets_engine="ultisnips"
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_complete_copen=1
let g:clang_hl_errors=1
let g:clang_periodic_quickfix=1

" move to the middle of the physical line without trailing white space. {{{
function! s:Gm()
  execute 'normal! ^'
  let first_col = virtcol('.')
  execute 'normal! g_'
  let last_col  = virtcol('.')
  execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction
nnoremap <silent> gm :call <SID>Gm()<CR>
" }}}

" cpplint.py
if !exists("lint_autocommand_loaded")
  let lint_autocommand_loaded = 1
  au FileType json <buffer> set equalprg=json_reformat
  au BufRead *.json set filetype=json
  au BufRead nginx.conf set filetype=nginx

  au BufRead *.cpp,*.c,*.cc,*.hpp,*.h noremap <buffer> <Leader>l :call Cpplint()<CR>
  au BufRead *.cpp,*.c,*.cc,*.hpp,*.h noremap <buffer> <Leader>t :call CppRunTests("")<CR>
  au BufRead *.js noremap <buffer> <Leader>l :call Jslint()<CR>
endif

function! CppRunTests(args)
  let l:old_makeprg = &makeprg
  let l:old_cwd = getcwd()
  exec 'lcd '.l:old_cwd.'/test/build_debug/'
  set makeprg=./tests
  if a:args == ""
    if exists("s:latest_args")
      exec 'make '.s:latest_args
    else
      exec 'make --gtest_filter=*'
    endif
  else
    exec 'make '.a:args
  endif
  let s:latest_args = a:args
  exec 'lcd '.l:old_cwd
  let &makeprg=l:old_makeprg
endfunction

function! Cpplint()
  let l:old_makeprg = &makeprg
  set makeprg=python\ ~/cpplint.py\ --filter=-legal/copyright,-readability/streams,-runtime/int\ %
  make
  let &makeprg=l:old_makeprg
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
