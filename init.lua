vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy
vim.g.python_recommended_style = 0

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

vim.cmd("nnoremap ' `")

vim.g.BufKillCreateMappings = 0

require("lazy").setup({
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    -- { import = "lazyvim.plugins.extras.formatting.prettier" },
    opts = {
      colorscheme = "everforest",
      mouse = "",
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      -- enabled = false,
      -- cmdline = {
      --   enabled = false, -- enables the Noice cmdline UI
      -- },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        -- enabled = false, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    -- easily jump to any location and enhanced f/t motions for Leap
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "echasnovski/mini.ai",
    enabled = false,
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Grpc",
    ft = ".grpc",
  },
  {
    --   -- name = "gramic",
    -- lazy = false,
    dir = "~/dotvim", -- lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "akinsho/toggleterm.nvim" },
    opts = {
      log_level = "debug",
    },
    config = function(_, opts)
      require("gramic.globals")
      require("gramic-bazel").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          require("config.autocmds")
        end,
      })
    end,
    keys = {
      { "<C-l>" },
      { "<S-l>" },
      { "<S-h>" },
      {
        "<leader><leader>x",
        "<cmd>w<cr><cmd>source %<cr>",
        desc = "Write and source current file",
      },
      {
        "<leader>uh",
        "<cmd>set hlsearch<cr>",
        desc = "Switch hlsearch on",
      },
      {
        "gb",
        require("gramic-bazel").find_in_bazel_build,
        desc = "Find current file in BUILD file rule",
      },
      {
        "<leader>bb",
        require("gramic-bazel").kill_bazel_and_restart_terminal,
        desc = 'Exec latest terminal "C command',
      },
      {
        "<leader>rr",
        function()
          -- vim.cmd("<cmd>w<cr><cmd>source %<cr>")
          require("gramic.globals")
          R("gramic-bazel")
        end,
        desc = 'Exec latest terminal "C command',
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
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- {import = "gramic-bazel"},
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = {
  --     sources = {},
  --   },
  -- },
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
    end,
  },
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },
  {
    -- vertical column line
    "m4xshen/smartcolumn.nvim",
    opts = {
      -- custom_colorcolumn = { python = "80" },
    },
  },
  "gcmt/taboo.vim",
  -- {
  --   "nanozuki/tabby.nvim",
  --   config = true,
  -- },
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
  { "google/vim-glaive", dependencies = { "google/vim-maktaba" } },
  { "google/vim-jsonnet" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "everforest",
        section_separators = "",
        component_separators = "",
        globalstatus = false,
      },
      sections = {
        lualine_a = { "%{winnr()}" },
        lualine_b = {},
        lualine_c = {
          { "filename", color = "DiffAdd" },
          { "filename", path = 1 },
        },
      },
      inactive_sections = {
        lualine_a = { "%{winnr()}" },
        lualine_b = {},
        lualine_c = {
          "filename",
          { "filename", path = 1, show_filename_only = false },
        },
        lualine_x = { "location", "progress" },
        lualine_y = {},
        lualine_z = {},
      },
      -- tabline = {
      --   lualine_a = { { 'tabs', mode = 2 } },
      --   lualine_b = {},
      --   lualine_c = {
      --     { 'filename', path = 1 }
      --   },
      --   lualine_x = {},
      --   lualine_y = {},
      --   lualine_z = {}
      -- }
    },
  },
  { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    opts = {
      ensure_installed = {
        "vimdoc",
      },
    },
  },
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
  { "folke/trouble.nvim", config = true },
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
  { "junegunn/fzf", build = "./install --bin" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf" },
    config = true,
    keys = {
      { "<leader>ff", "<cmd>FzfLua git_files<cr>", desc = "Find git files" },
      { "<leader>fm", "<cmd>FzfLua oldfiles<cr>", desc = "Old files" },
      {
        "<leader>fg",
        "<cmd>FzfLua live_grep_native<cr>",
        desc = "Live grep native",
      },
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
  {
    "chrishrb/gx.nvim",
    event = { "BufEnter" },
    opts = {
      -- specify your browser app; default for linux "xdg-open"
      open_browser_app = "open",
      handlers = {
        plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
        github = true, -- open github issues
      },
    },
  },
  { import = "plugins" },
})

if vim.fn.has('"unix"') then
  if vim.env.WSL_DISTRO_NAME ~= nil then
    if vim.fn.executable("gclpr") == 1 then
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
    if vim.fn.executable(vim.env.HOME .. "/winhome/.wsl/gclpr.exe") == 1 then
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

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
  end,
})
