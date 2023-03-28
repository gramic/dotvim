-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local set = vim.opt -- set options
set.undofile = true
set.tabstop = 2
set.shiftwidth = 2
set.smarttab = true
set.smartindent = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.hlsearch = false
set.expandtab = true
set.autoread = true
set.fixendofline = false
set.swapfile = false
set.sessionoptions:append({ "tabpages,globals" }) -- to save TabooRename names
set.keymap = "bulgarian-phonetic"
set.iminsert = 0
set.imsearch = 0
set.numberwidth = 2
set.mouse = ""
