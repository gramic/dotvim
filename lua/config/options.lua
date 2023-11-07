-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt -- set options
opt.spelllang = "en,bg"
opt.clipboard = ""
opt.cursorline = false -- Enable highlighting of the current line
opt.wrap = true -- Disable line wrap
opt.splitbelow = false -- Put new windows above current
opt.splitright = false
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
opt.sessionoptions:append({ "tabpages,globals,terminal" }) -- to save TabooRename names
opt.keymap = "bulgarian-phonetic"
opt.iminsert = 0
opt.imsearch = 0
opt.numberwidth = 2
opt.mouse = ""
opt.scrolloff = 0
opt.number = false
opt.relativenumber = false
opt.wildmode = "full" -- Command-line completion mode
