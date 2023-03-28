-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt -- set options
opt.undofile = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smarttab = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false
opt.expandtab = true
opt.autoread = true
opt.fixendofline = false
opt.swapfile = false
opt.sessionoptions:append({ "tabpages,globals" }) -- to save TabooRename names
opt.keymap = "bulgarian-phonetic"
opt.iminsert = 0
opt.imsearch = 0
opt.numberwidth = 2
opt.mouse = ""
opt.scrolloff = 0
opt.number = false
opt.relativenumber = false
