" tabdir.vim - Continuously updated tablinestatus
" Maintainer:   Stanimir Mladenov <https://gramic.github.io/>
" Version:      1.0

if exists("g:loaded_tabdir") || v:version < 702
    finish
endif
let g:loaded_tabdir = 1

function! s:dirname(bufname)
    return fnamemodify(a:bufname, ':p:h:t')
endfunction

fu s:bufdir(tabnr)
    let buffers = tabpagebuflist(a:tabnr)
    let buf = s:first_normal_buffer(buffers)
    let bname = s:dirname(bufname(buf > -1 ? buf : buffers[0]))
    if !empty(bname)
        return 'eeeeee'
    endif
    return g:taboo_unnamed_tab_label
endfu


function! s:first_normal_buffer(buffers)
    for buf in a:buffers
        if buflisted(buf) && getbufvar(buf, "&bt") != 'nofile'
            return buf
        end
    endfor
    return -1
endfu

" To construct the tabline string for terminal vim.
function! TabdirTabline(...) abort
    let tabline = ''
    for i in s:tabs()
        let tabline .= i == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'
        let title = s:gettabvar(i, "tabdir_tab_name")
        let fmt = empty(title) ? g:tabdir_tab_format : g:tabdir_renamed_tab_format
        let tabline .= '%' . i . 'T'
        let tabline .= s:expand(i, fmt)
    endfor
    let tabline .= '%#TabLineFill#%T'
    let tabline .= '%=%#TabLine#%999X' . g:tabdir_close_tabs_label
    return tabline
endfunction

augroup tabdir
  autocmd!
  autocmd TabEnter *
        \ if !get(g:, 'tabdir_no_tabenter') |
        "\   exe s:persist() |
        \ endif
  "autocmd User Flags call Hoist('global', 'ObsessionStatus')
augroup END

