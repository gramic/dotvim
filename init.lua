vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "gramic/dotvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    url = "git@github.com:gramic/dotvim.git",
    build = "git remote add upstream git@github.com:gramic/dotvim.git",
  },
  {import = "plugins"},
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "tpope/vim-dadbod",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  "tpope/vim-rhubarb",
  "tpope/vim-vinegar",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",
  "tpope/vim-obsession",
  "tpope/vim-abolish",
  "tpope/vim-characterize",
  "tpope/vim-dispatch",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "nvim-lua/plenary.nvim",
  "L3MON4D3/LuaSnip",
  { "junegunn/fzf", build = "./install --bin"},
  {"ibhagwan/fzf-lua",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'junegunn/fzf' },
    config = true,
    keys = {
      {"<leader>ff", "<cmd>FzfLua git_files<cr>", desc = "Find git files"},
      {"<leader>fm", "<cmd>FzfLua oldfiles<cr>", desc = "Old files"},
    },
  },
  "justinmk/vim-dirvish",
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
})

local set = vim.opt -- set options
set.undofile=true
set.tabstop=2
set.shiftwidth=2
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
-- set.sessionoptions+=tabpages,globals
set.keymap = "bulgarian-phonetic"
set.iminsert=0
set.imsearch=0
set.numberwidth=2
set.mouse=""

if vim.fn.has('"unix"') then
  if vim.env.WSL_DISTRO_NAME ~= nil then
    if vim.fn.executable('gclpr') == 1 then
      vim.g.clipboard = [[
          {
            'name': 'gclpr',
            'copy': {
               '+': 'gclpr copy',
               '*': 'gclpr copy',
             },
            'paste': {
               '+': 'gclpr paste --line-ending lf',
               '*': 'gclpr paste --line-ending lf',
            },
            'cache_enabled': 0,
          }
      ]]
    end
  else
    if vim.fn.executable(vim.env.HOME .. '/winhome/.wsl/gclpr.exe') == 1 then
      vim.g.clipboard = [[
          {
            'name': 'gclpr',
            'copy': {
               '+': $HOME . '/winhome/.wsl/gclpr.exe copy',
               '*': $HOME . '/winhome/.wsl/gclpr.exe copy',
             },
            'paste': {
               '+': $HOME . '/winhome/.wsl/gclpr.exe paste --line-ending lf',
               '*': $HOME . '/winhome/.wsl/gclpr.exe paste --line-ending lf',
            },
            'cache_enabled': 0,
          }
      ]]
    end
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

