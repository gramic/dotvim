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

set t_Co=256
set undofile
set undodir=~/.vim_runtime/undodir
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
syntax on

if has('gui_win32')
  set clipboard=
  set guifont=Consolas:h11
elseif
  " Since I use linux, I want this
  set clipboard+=unnamed
endif

"set my prefered color scheme
"set term=gnome-256color

" color column
set colorcolumn=81

" Match trailing whitespace, except when typing at the end of a line.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
autocmd BufReadPost fugitive://* set bufhidden=delete

"hi ColorColumn guibg=#2d2d2d
"hi ColorColumn guibg=#fafafa
"hi ColorColumn guifg=#ff0000

set numberwidth=2

" clear highlighting on <esc> press
nnoremap <esc> :noh<return><esc>

" Bundles:
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "git@github.com:gramic/dotvim.git"

"Bundle "vundle.vim"
Bundle "Tabular"
Bundle "CSApprox"
Bundle "Color-Sampler-Pack"
Bundle "FuzzyFinder"
Bundle "JavaScript-syntax"
Bundle "Javascript-Indentation"
Bundle "L9"
Bundle "ScrollColors"
"Bundle "SuperTab-continued."
Bundle "The-NERD-Commenter"
Bundle "The-NERD-tree"
Bundle "YankRing.vim"
Bundle "ZenCoding.vim"
Bundle "ZoomWin"
Bundle "cecutil"
Bundle "git://github.com/Rip-Rip/clang_complete.git"
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
Bundle "git://github.com/garbas/vim-snipmate.git"
Bundle "surround.vim"
Bundle "bufkill.vim"
Bundle "git://github.com/skammer/vim-css-color.git"
Bundle "git://github.com/duganchen/vim-soy"
"Syntaxes
Bundle 'javascript.vim--Frstenberg'
Bundle 'JSON.vim'
Bundle 'nginx.vim'

filetype off
Bundle "altercation/vim-colors-solarized"


filetype plugin indent on
set background=light
let g:solarized_termcolors=256
colorscheme solarized
set background=light

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

"""""""""""""""""""""""""""""""""""""""
"           Menu completions          "
"""""""""""""""""""""""""""""""""""""""
set wildmode=full wildmenu                 " Command-line tab completion
set infercase                              " AutoComplete in Vim
set completeopt=longest,menu,menuone
set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db,*.swc

"Gui options
:set guioptions=ai  "remove all gui options except select copy buffer and icon

" have the h and l cursor keys wrap between lines
" (like </space><space> and <bkspc> do by default),
" and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

"map copy to end of line
map Y y$
"Make the single quote work like a backtick
map ' `

"save with Ctrl + S
:map <C-S> :w<CR>
:imap <C-S> <Esc>:w<CR>

" Save files with sudo rights if you forgot
:command! W w !sudo tee % > /dev/null

"nmap Space to PageDown and Shift Space to PageUp
:nmap <Space> <PageDown>
:nmap <S-Space> <PageUp>

"map omni completion keys to Ctrl + Space
:imap <C-Space> <C-X><C-O>

"wildmenu that can be used like :e <C-D>
set wildmenu


" our style is curly brace at the end of the function signature
autocmd BufNewFile,BufRead *.js map [[ ?function(.*)\ {$<CR>
autocmd BufNewFile,BufRead *.js map ]] /^};$<CR>
autocmd BufNewFile,BufRead *.js map <C-j> :!gjslint --strict %<CR>

"turn omni completion on
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"set tags+=~/.vim/closuretags

"Doxygen Toolkit settings for javascript comments
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_startCommentTag = "/** "
let g:DoxygenToolkit_startCommentBlock = "/* "
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre = "@param {} "
let g:DoxygenToolkit_interCommentTag=" * "
let g:DoxygenToolkit_endCommentTag = " */"
let g:DoxygenToolkit_endCommentBlock = " */"

"Error format
"autocmd FileType json set errorformat=%E%f:\ %m\ at\ line\ %l,%-G%.%#
"set errorformat=%E%f:%l:\ WARNING\ -\ %m,%C,%C%p^

" Soy files to be syntax html like
":au! BufNewFile,BufRead *.soy set filetype=html

" Developing Javascript mappings
set makeprg=make\ -C\ ./test/build_debug
nmap <leader>bb :make -j 2 docs_app js_target<CR>
nmap <F5> :make -j 2 docs_app js_target<CR>
nmap <leader>br :set makeprg=make\ -C\ ./build_release<CR><Bar>:!cd ./build_release && cmake .. -DJDEBUG=OFF<CR>
nmap <C-F5> :set makeprg=make\ -C\ ./build_release<CR><Bar>:!cd ./build_release && cmake .. -DJDEBUG=OFF<CR>
nmap <leader>bd :set makeprg=make\ -C\ ./build_debug<CR><Bar>:!cd ./build_debug && cmake .. -DJDEBUG=ON<CR>
nmap <S-F5> :set makeprg=make\ -C\ ./build_debug<CR><Bar>:!cd ./build_debug && cmake .. -DJDEBUG=ON<CR>

" convert json property to exported closure compiler name
map <leader>j bi["<Esc>ea"]<Esc>


" Command Make will call make and then cwindow which
" opens a 3 line error window if any errors are found.
" If no errors, it closes any open cwindow.
:command! -nargs=* Make make <args>

" DBExt profiles
let g:dbext_default_profile_mysql_local = 'type=MYSQL:user=root:passwd=root:dbname=test3:host=localhost'
let g:dbext_default_profile_SQLSRV      = 'type=SQLSRV:user=sa:passwd=sdfggsfd:host=192.168.0.2:replace_title=1:dbname=sofica'

" NERDTree
:noremap <Leader>F :NERDTreeToggle<CR>

let NERDTreeHijackNetrw=1
let NERDTreeMouseMode=1
let NERDTreeWinSize=50
let NERDTreeQuitOnOpen=1

let NERDSpaceDelims=2

" Fuzzy Finder js
let g:fuf_coveragefile_prompt = '>js[]>'
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|hotel.*/|build.*/'
noremap <Leader>f :call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns',['**/*.js','**/*.soy', '**/*.css']])<CR><BAR>:FufCoverageFile<CR>
" Fuzzy Finder cpp
" let g:fuf_coveragefile_prompt = '>cpp[]>'
" let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|build.*/'
" noremap <Leader>f :call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns',['**/*.h','**/*.hpp', '**/*.c', '**/*.cpp', '**/CMakeLists.txt']])<CR><BAR>:FufCoverageFile<CR>

" FuzzyFinder mappings
noremap <Leader>b :FufBuffer<CR>
let g:fuf_modesDisable=['mrucmd']
let g:fuf_buffer_mruOrder=1
noremap <Leader>m :FufMruFile<CR>


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
let g:clang_user_options="-I/".g:home_dir."/opt/clang/3.0/include"
let g:clang_auto_user_options="-I/".g:home_dir."/opt/clang/3.0/include, .clang_complete"
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_complete_copen=1

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
  set errorformat=l:old_errorformat
endfunction

