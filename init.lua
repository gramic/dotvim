vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy

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
set.sessionoptions:append{"globals"} -- to save TabooRename names
set.keymap = "bulgarian-phonetic"
set.iminsert=0
set.imsearch=0
set.numberwidth=2
set.mouse=""

vim.g.BufKillCreateMappings = 0

vim.keymap.set("n", "<leader>bb", "'Ci<up><enter>mamCG",
              {desc = "Exec latest terminal \"C command"}
              )

require("lazy").setup({
  {
  --   -- name = "gramic",
    dir = "~/dotvim",    -- lazy = false,
    keys = {
      {
        "gb", require("gramic-bazel").find_in_bazel_build,
        desc = "Find current file in BUILD file rule",
      },
    },
  --   -- priority = 1000,
  --   -- url = "git@github.com:gramic/dotvim.git",
  --   -- build = "git remote add upstream git@github.com:gramic/dotvim.git",
  },
  -- {import = "gramic-bazel"},
  {import = "plugins"},
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  {
    "m4xshen/smartcolumn.nvim",
    config = true,
  },
  "gcmt/taboo.vim",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",
  "vim-scripts/dbext.vim",
  "sindrets/diffview.nvim",
  "shumphrey/fugitive-gitlab.vim",
  "mbbill/undotree",
  "qpkorr/vim-bufkill",
  "nelstrom/vim-visual-star-search",
  "duganchen/vim-soy",
  -- Add maktaba and codefmt to the runtimepath.
  "google/vim-maktaba",
  {"google/vim-codefmt", dependencies = {"google/vim-maktaba"}},
  -- Also add Glaive, which is used to configure codefmt's maktaba flags. See
  -- `:help :Glaive` for usage.
  {"google/vim-glaive", dependencies = {"google/vim-maktaba"}},
  {"google/vim-jsonnet"},
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    opts = {
      options = {
        theme = 'gruvbox',
        section_separators = '', component_separators = '',
      },
      inactive_sections = {
        lualine_a = {'%{winnr()}'},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
  {"nvim-treesitter/playground"},
  {"nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {"nvim-tree/nvim-web-devicons"},
  },
  {"ConradIrwin/vim-bracketed-paste"},
  -- {dir = "~/gramic-neovim/plugin/gramic-neovim.vim"},
  {"ryvnf/readline.vim"},
  {"folke/trouble.nvim", config = true},
  {"p00f/clangd_extensions.nvim"},
  {"jpetrie/vim-counterpoint"},
  "tpope/vim-dadbod",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  "tpope/vim-rhubarb",
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
  { 'echasnovski/mini.nvim', version = false },
  {"junegunn/fzf", build = "./install --bin"},
  {"ibhagwan/fzf-lua",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'junegunn/fzf' },
    config = true,
    keys = {
      {"<leader>ff", "<cmd>FzfLua git_files<cr>", desc = "Find git files"},
      {"<leader>fm", "<cmd>FzfLua oldfiles<cr>", desc = "Old files"},
    },
  },
  "justinmk/vim-dirvish",
  -- {
  --   'stevearc/oil.nvim',
  --   -- config = function() require('oil').setup() end
  --   config = true,
  --   opts = {
  --     view_options = {
  --       show_hidden = true,
  --     },
  --   },
  -- },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  -- {
  --     "shaunsingh/nord.nvim",
  --     lazy = false,
  --     priority = 1000,
  --     config = function()
  --       -- load the colorscheme here
  --       vim.cmd([[colorscheme nord]])
  --     end,
  -- },
  -- {
  --     "EdenEast/nightfox.nvim",
  --     lazy = false,
  --     priority = 1000,
  --     config = function()
  --       -- load the colorscheme here
  --       vim.cmd([[colorscheme dayfox]])
  --     end,
  -- },
  {
    "tpope/vim-commentary",
    config = false,
  },
})

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

