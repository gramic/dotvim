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
vim.filetype.add({ extension = { grpcurl = "grpcurl" } })

vim.g.BufKillCreateMappings = 0

local function ext_encoding()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].bomb then
    return string.format("%s (bom)", vim.bo[bufnr].fileencoding)
  else
    return vim.bo[bufnr].fileencoding
  end
end

require("lazy").setup({
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
    spec = {
      import = "lazyvim.plugins.extras.formatting.prettier",
      { import = "lazyvim.plugins.extras.lang.typescript" },
      { import = "lazyvim.plugins.extras.lang.json" },
      { import = "lazyvim.plugins.extras.lang.clangd" },
      { import = "lazyvim.plugins.extras.lang.python" },
      dev = {
        path = "~/work",
      },
    },
    opts = {
      colorscheme = "everforest",
      mouse = "",
      defaults = {
        autocmds = true, -- lazyvim.config.autocmds
        keymaps = false, -- lazyvim.config.keymaps
        -- lazyvim.config.options can't be configured here since that's loaded before lazyvim setup
        -- if you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
      },
    },
  },
  {
    "allaman/emoji.nvim",
    version = "1.0.0", -- optionally pin to a tag
    ft = "markdown", -- adjust to your needs
    dependencies = {
      -- optional for nvim-cmp integration
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      enable_cmp_integration = true,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        py = { "python" },
        bzl = { "buildifier" },
      },
      formatters = {
        yapf = {
          prepend_args = { "--style", "google" },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
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
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- search quick with s keymap
  {
    "folke/flash.nvim",
    enabled = false,
  },
  -- buffer remove
  {
    "echasnovski/mini.bufremove",
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
    "echasnovski/mini.comment",
    enabled = false,
  },
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = "*",
  --   lazy = false,
  --   config = true,
  -- },
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Worktree",
    opts = {},
    config = function()
      require("telescope").load_extension("git_worktree")
    end,
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      -- Your options go here
      name = { ".*.venv", "venv" },
      auto_refresh = true,
    },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      {
        -- Keymap to open VenvSelector to pick a venv.
        "<leader>vs",
        "<cmd>:VenvSelect<cr>",
        -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
        "<leader>vc",
        "<cmd>:VenvSelectCached<cr>",
      },
    },
  },
  {
    "AntonVanAssche/date-time-inserter.nvim",
    ft = "markdown",
    opts = {
      date_format = "DDMMYYYY",
      date_separator = ".",
      time_format = 24,
      insert_date_map = "",
      insert_time_map = "",
      insert_date_time_map = "",
    },
    keys = {
      {
        "<leader>tt",
        "<cmd>InsertDateTime<cr>",
        desc = "Insert date and time.",
      },
      {
        "<M-;>",
        "<cmd>InsertDateTime<cr>",
        mode = { "i" },
        desc = "Insert date and time.",
      },
    },
  },
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Grpc",
    ft = ".grpcurl",
  },
  {
    "gramic/tree-sitter-grpcurl",
    dev = true,
    dir = "~/work/tree-sitter-grpcurl", -- lazy = false,
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = false,
      update_events = "TextChanged,TextChangedI",
      -- delete_check_events = "TextChanged",
    },
    keys = function()
      return {
        { "<tab>", false },
        {
          "<c-j>",
          function()
            return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next"
              or "<c-j>"
          end,
          expr = true,
          silent = true,
          mode = "i",
        },
        {
          "<c-e>",
          function()
            return require("luasnip").choice_active()
                and "<Plug>luasnip-next-choice"
              or "<Plug>luasnip-jump-next"
          end,
          expr = true,
          silent = true,
          mode = "i",
        },
      }
    end,
  },
  {
    name = "dotvim",
    dir = "~/work/dotvim", -- lazy = false,
    version = false,
    ft = { "jsonnet", "cpp", "javascript", "bzl", "grpcurl" },
    opts = {
      log_level = "debug",
    },
    -- event = "BufEnter *.js",
    dependencies = {
      "LazyVim/LazyVim",
      "nvim-lua/plenary.nvim",
      "akinsho/toggleterm.nvim",
      "nvim-treesitter/nvim-treesitter",
      "google/vim-glaive",
      "L3MON4D3/LuaSnip",
    },
    config = function(_, opts)
      vim.print("dotvim config called")
      vim.cmd([[Glaive codefmt clang_format_style=Google]])
      require("gramic.soy-snippets")
      require("gramic.javascript-snippets")
      require("gramic.bzl-snippets")
      -- require("gramic.globals")
      require("gramic-bazel").setup(opts)
      require("grpcurl").setup(opts)
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
      -- toggle options
      {
        "<leader>uf",
        function()
          require("lazyvim.plugins.lsp.format").toggle()
        end,
        desc = "Toggle format on Save",
      },
      {
        "<leader>us",
        function()
          require("lazyvim.util").toggle("spell")
        end,
        desc = "Toggle Spelling",
      },
      {
        "<leader>uw",
        function()
          require("lazyvim.util").toggle("wrap")
        end,
        desc = "Toggle Word Wrap",
      },
      {
        "<leader>ul",
        function()
          require("lazyvim.util").toggle("relativenumber", true)
          require("lazyvim.util").toggle("number")
        end,
        desc = "Toggle Line Numbers",
      },
      {
        "<leader>ud",
        function()
          require("lazyvim.util").toggle_diagnostics()
        end,
        desc = "Toggle Diagnostics",
      },
      {
        "<leader>uc",
        function()
          require("lazyvim.util").toggle(
            "conceallevel",
            false,
            { 0, vim.o.conceallevel }
          )
        end,
        desc = "Toggle Conceal",
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
          -- R("gramic-bazel")
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
    "numine777/py-bazel.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      -- pip_deps_marker = "typesense",
      -- global_pyright_config =
    },
    -- config = function(_, opts)
    --   require("py-bazel").setup(opts or {})
    -- end,
  },
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "duganchen/vim-soy",
  "jamessan/vim-gnupg",
  "kristijanhusak/vim-dadbod-completion",
  "kristijanhusak/vim-dadbod-ui",
  -- Add maktaba and codefmt to the runtimepath.
  {
    "google/vim-maktaba",
  },
  {
    "google/vim-codefmt",
    dependencies = { "google/vim-maktaba", "google/vim-glaive" },
  },
  {
    "google/vim-glaive",
    dependencies = { "google/vim-maktaba", "google/vim-codefmt" },
    lazy = false,
    -- command = "Glaive",
    config = function()
      vim.cmd([[Glaive codefmt clang_format_style=Google]])
    end,
  },
  { "google/vim-jsonnet" },
  {
    "vim-scripts/dbext.vim",
    command = "DBExecVisualSQL",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "vimdoc",
        "proto",
        "json",
        "grpcurl",
        "starlark",
        "javascript",
        "query",
        "jsdoc",
      })
    end,
  },
  -- { "folke/neoconf.nvim", cmd = "Neoconf" },
  {
    -- vertical column line
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "81",
    },
  },
  "gcmt/taboo.vim",
  "sindrets/diffview.nvim",
  {
    "shumphrey/fugitive-gitlab.vim",
    dependencies = { "tpope/vim-fugitive" },
  },
  "mbbill/undotree",
  "qpkorr/vim-bufkill",
  "nelstrom/vim-visual-star-search",
  { "navarasu/onedark.nvim" }, -- colorscheme
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
          {
            "harpoon2",
            indicators = { "h", "t", "n", "s" },
            active_indicators = { "H", "T", "N", "S" },
          },
        },
        lualine_x = { ext_encoding },
      },
      inactive_sections = {
        lualine_a = { "%{winnr()}" },
        lualine_b = {},
        lualine_c = {
          "filename",
          { "filename", path = 1, show_filename_only = false },
        },
        lualine_x = { "location", "progress", ext_encoding },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  { "ConradIrwin/vim-bracketed-paste" },
  -- {dir = "~/gramic-neovim/plugin/gramic-neovim.vim"},
  { "ryvnf/readline.vim" },
  { "folke/trouble.nvim", config = true },
  { "p00f/clangd_extensions.nvim", config = true },
  { "jpetrie/vim-counterpoint" },
  "tpope/vim-dadbod",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  "tpope/vim-rhubarb",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-repeat",
  -- "tpope/vim-unimpaired",
  "tpope/vim-obsession",
  {
    "gregorias/coerce.nvim",
    tag = "v0.1.1",
    config = true,
  },
  {
    "tpope/vim-abolish",
    init = function()
      -- Disable coercion mappings. I use coerce.nvim for that.
      vim.g.abolish_no_mappings = true
    end,
  },
  "tpope/vim-characterize",
  "tpope/vim-dispatch",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    "nvim-lua/plenary.nvim",
  },
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Find Git File",
      },
      {
        "<leader>fl",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find Live Grep",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = false,
      },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    keys = {
      {
        "<leader>a",
        function()
          local harpoon = require("harpoon")
          harpoon:list():append()
        end,
        desc = "Harpoon append",
      },
      {
        "<C-e>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon list",
      },
      {
        "<C-h>",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon select 1",
      },
      {
        "<C-t>",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon select 2",
      },
      {
        "<C-n>",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon select 3",
      },
      {
        "<C-s>",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon select 4",
      },
      {
        "<C-S-P>",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Harpoon prev",
      },
      {
        "<C-S-N>",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Harpoon next",
      },
    },
    opts = {
      settings = {
        sync_on_ui_close = true,
      },
    },
  },
  { "junegunn/fzf", build = "./install --bin" },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf" },
    config = true,
    -- command = "FzfLua",
    keys = {
      {
        "<leader>fg",
        "<cmd>FzfLua live_grep_glob<cr>",
        desc = "Live grep glob",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Open parent directory",
      },
    },
    opts = {
      keymaps = {
        ["<leader>fd"] = {
          callback = function()
            path = require("oil").get_current_dir()
            require("telescope.builtin").live_grep({
              search_dirs = { path },
              prompt_title = string.format("Grep in [%s]", path),
            })
          end,
          desc = "Live grep in current directory",
          mode = "n",
        },
      },
      view_options = {
        show_hidden = true,
        sort = {
          { "name", "asc" },
        },
      },
    },
  },
  {
    cmd = "DirDiff",
    "will133/vim-dirdiff",
  },
  -- {
  --   "tpope/vim-commentary",
  --   config = false,
  -- },
  {
    "tomtom/tcomment_vim",
    -- opts = {},
  },
  {
    "mvllow/stand.nvim",
    opts = {},
  },
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    submodules = false, -- not needed, submodules are required only for tests
    -- you can specify also another config if you want
    config = function()
      require("gx").setup({
        -- open_browser_app = "open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
        -- open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
        handlers = {
          plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
          github = true, -- open github issues
          brewfile = true, -- open Homebrew formulaes and casks
          package_json = true, -- open dependencies from package.json
          search = true, -- search the web/selection on the web if nothing else is found
        },
        handler_options = {
          search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
        },
      })
    end,
  },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.editor.symbols-outline" },
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  -- { import = "lazyvim.plugins.extras.coding" },
  { import = "plugins" },
})

if vim.fn.has("unix") == 1 then
  if vim.env.WSL_DISTRO_NAME ~= nil then
    if vim.fn.executable("gclpr") == 1 then
      vim.g.clipboard = {
        name = "gclpr",
        copy = {
          ["+"] = { "gclpr", "copy" },
          ["*"] = { "gclpr", "copy" },
        },
        paste = {
          ["+"] = { "gclpr", "paste --line-ending lf" },
          ["*"] = { "gclpr", "paste --line-ending lf" },
        },
        cache_enabled = 0,
      }
    end
  else
    if vim.fn.executable(vim.env.HOME .. "/winhome/.wsl/gclpr.exe") == 1 then
      vim.g.clipboard = {
        name = "gclpr",
        copy = {
          ["+"] = vim.env.HOME .. "/winhome/.wsl/gclpr.exe copy",
          ["*"] = vim.env.HOME .. "/winhome/.wsl/gclpr.exe copy",
        },
        paste = {
          ["+"] = vim.env.HOME
            .. "/winhome/.wsl/gclpr.exe paste --line-ending lf",
          ["*"] = vim.env.HOME
            .. "/winhome/.wsl/gclpr.exe paste --line-ending lf",
        },
        cache_enabled = 0,
      }
    elseif vim.fn.executable("gclpr") == 1 then
      vim.g.clipboard = {
        name = "gclpr",
        copy = {
          ["+"] = { "gclpr", "copy" },
          ["*"] = { "gclpr", "copy" },
        },
        paste = {
          ["+"] = { "gclpr", "paste" },
          ["*"] = { "gclpr", "paste" },
        },
        cache_enabled = 0,
      }
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
