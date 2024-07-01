-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = true
vim.g.tcomment_mapleader2 = false
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy
vim.g.python_recommended_style = 0

local opt = vim.opt -- set options
opt.langmap =
  "Ч~,ЯQ,ВW,ЕE,РR,ТT,ЪY,УU,ИI,ОO,ПP,Ш{,Щ},АA,СS,ДD,ФF,ГG,ХH,ЙJ,КK,ЛL,ЗZ,ЬZ,ЦC,ЖV,БB,НN,МM,ч`,яq,вw,еe,рr,тt,ъy,уu,иi,оo,пp,ш[,щ],аa,сs,дd,фf,гg,хh,йj,кk,лl,зz,ьz,цc,жv,бb,нn,мm"
opt.breakindent = true
opt.spelllang = "en,bg"
opt.clipboard = ""
opt.cursorline = false -- Enable highlighting of the current line
opt.wrap = true -- Disable line wrap
opt.splitbelow = true -- Put new windows above current
opt.splitkeep = "cursor"
opt.splitright = true
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
opt.cmdheight = 1
opt.conceallevel = 0
