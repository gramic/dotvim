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
set.sessionoptions:append { "globals" } -- to save TabooRename names
set.keymap = "bulgarian-phonetic"
set.iminsert = 0
set.imsearch = 0
set.numberwidth = 2
set.mouse = ""

vim.g.BufKillCreateMappings = 0

vim.keymap.set("n", "<leader>bb", "'Ci<up><enter>mamCG",
  { desc = "Exec latest terminal \"C command" }
)
vim.o.termguicolors = true
vim.g.background = "light"

require("lazy").setup({
  -- {
  --   "LazyVim/LazyVim",
  --   -- opts = {
  --   --   colorscheme = "everforest",
  --   -- },
  -- },
  {
    --   -- name = "gramic",
    dir = "~/dotvim", -- lazy = false,
    config = false,
    init = function()

    end,
    keys = {
      {
        "gb",
        require("gramic-bazel").find_in_bazel_build,
        desc = "Find current file in BUILD file rule",
      },
      { "<M-1>", "1gt", desc = "Go to first tab" },
      { "<M-2>", "2gt", desc = "Go to second tab" },
      { "<M-3>", "3gt", desc = "Go to third tab" },
      { "<M-4>", "4gt", desc = "Go to forth tab" },
      { "<M-5>", "5gt", desc = "Go to fifth tab" },
    },
    --   -- priority = 1000,
    --   -- url = "git@github.com:gramic/dotvim.git",
    --   -- build = "git remote add upstream git@github.com:gramic/dotvim.git",
  },
  -- {import = "gramic-bazel"},
  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
      },
    },
  },
  -- {
  --   "bazelbuild/vim-bazel",
  --   dependencies = { "google/vim-maktaba" },
  --   ft = "bzl",
  -- },
  {
    "numine777/py-bazel.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      pip_deps_marker = "typesense",
    },
    config = function(_, opts)
      require("py-bazel").setup(opts or {})
    end
  },
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
  { "google/vim-codefmt", dependencies = { "google/vim-maktaba" } },
  -- {
  --   'alexander-born/bazel.nvim',
  --   dependencies = {'nvim-treesitter/nvim-treesitter'},
  --   -- ft = 'bzl',
  -- },
  -- {"alexander-born/cmp-bazel", dependencies = {"hrsh7th/nvim-cmp"}},
  -- Also add Glaive, which is used to configure codefmt's maktaba flags. See
  -- `:help :Glaive` for usage.
  { "google/vim-glaive",  dependencies = { "google/vim-maktaba" } },
  { "google/vim-jsonnet" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = 'everforest',
        section_separators = '',
        component_separators = '',
      },
      inactive_sections = {
        lualine_a = { '%{winnr()}' },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
  { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    -- event = "VeryLazy",
    -- config = function(_, opts)
    --   print(opts)
    --   require("nvim-treesitter.configs").setup(opts)
    -- end,
  },
  { "ConradIrwin/vim-bracketed-paste" },
  -- {dir = "~/gramic-neovim/plugin/gramic-neovim.vim"},
  { "ryvnf/readline.vim" },
  { "folke/trouble.nvim",             config = true },
  { "p00f/clangd_extensions.nvim" },
  { "jpetrie/vim-counterpoint" },
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
  {
    "nvim-lua/plenary.nvim",
  },
  -- {
  --   'echasnovski/mini.nvim',
  --   version = false,
  -- },
  {
    'echasnovski/mini.nvim',
    version = false,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects", "folke/which-key.nvim" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter(
            { a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter(
            { a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- register all text objects with which-key
      ---@type table<string, string|table>
      local i = {
        [" "] = "Whitespace",
        ['"'] = 'Balanced "',
        ["'"] = "Balanced '",
        ["`"] = "Balanced `",
        ["("] = "Balanced (",
        [")"] = "Balanced ) including white-space",
        [">"] = "Balanced > including white-space",
        ["<lt>"] = "Balanced <",
        ["]"] = "Balanced ] including white-space",
        ["["] = "Balanced [",
        ["}"] = "Balanced } including white-space",
        ["{"] = "Balanced {",
        ["?"] = "User Prompt",
        _ = "Underscore",
        a = "Argument",
        b = "Balanced ), ], }",
        c = "Class",
        f = "Function",
        o = "Block, conditional, loop",
        q = "Quote `, \", '",
        t = "Tag",
      }
      ---@type table<string, string|table>
      local a = vim.deepcopy(i)
      for k, v in pairs(a) do
        ---@diagnostic disable-next-line: param-type-mismatch
        a[k] = tostring(v:gsub(" including.*", ""))
      end
      local ic = vim.deepcopy(i)
      local ac = vim.deepcopy(a)
      for key, name in pairs({ n = "Next", l = "Last" }) do
        i[key] = vim.tbl_extend(
          "force", { name = "Inside " .. name .. " textobject" }, ic)
        a[key] = vim.tbl_extend(
          "force", { name = "Around " .. name .. " textobject" }, ac)
      end
      require("which-key").register({
        mode = { "o", "x" },
        i = i,
        a = a,
      })
    end,
  },
  { "junegunn/fzf",    build = "./install --bin" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'junegunn/fzf' },
    config = true,
    keys = {
      { "<leader>ff", "<cmd>FzfLua git_files<cr>", desc = "Find git files" },
      { "<leader>fm", "<cmd>FzfLua oldfiles<cr>",  desc = "Old files" },
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
    "tpope/vim-commentary",
    config = false,
  },
  { import = "plugins" },
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
