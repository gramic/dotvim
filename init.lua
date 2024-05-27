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
-- vim.filetype.add({ extension = { grpcurl = "grpcurl" } })

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
      colorscheme = "catppuccin-mocha",
      mouse = "",
      defaults = {
        autocmds = true, -- lazyvim.config.autocmds
        keymaps = false, -- lazyvim.config.keymaps
        -- lazyvim.config.options can't be configured here since that's loaded before lazyvim setup
        -- if you want to disable loading options, add `package.loaded["lazyvim.config.options"] = true` to the top of your init.lua
      },
    },
  },
  -- colorschemes
  "sainnhe/everforest",
  "ellisonleao/gruvbox.nvim",
  "shaunsingh/nord.nvim",
  "EdenEast/nightfox.nvim",
  {
    -- run :colorscheme synthweave or synthweave-transparent when feeling like it
    "samharju/synthweave.nvim",
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
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>hp",
        function()
          package.gitsigns.preview_hunk_inline()
        end,
        "Preview Hunk Inline",
      },
    },
    -- opts = {
    --   -- signs = {
    --   --   add = { text = "▎" },
    --   --   change = { text = "▎" },
    --   --   delete = { text = "" },
    --   --   topdelete = { text = "" },
    --   --   changedelete = { text = "▎" },
    --   --   untracked = { text = "▎" },
    --   -- },
    --   on_attach = function(buffer)
    --     local gs = package.loaded.gitsigns
    --
    --     local function map(mode, l, r, desc)
    --       vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
    --     end
    --
    --       -- stylua: ignore start
    --       map("n", "]h", gs.next_hunk, "Next Hunk")
    --       map("n", "[h", gs.prev_hunk, "Prev Hunk")
    --       map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
    --       map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
    --       map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
    --       map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
    --       map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
    --       map("n", "<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline")
    --       map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
    --       map("n", "<leader>hd", gs.diffthis, "Diff This")
    --       map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
    --       map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    --   end,
    -- },
  },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gt", false }
      keys[#keys + 1] = { "gI", false }
      keys[#keys + 1] = { "gd", vim.lsp.buf.definition, desc = "" }
      keys[#keys + 1] = {
        "<leader>lgd",
        "<Cmd>lua vim.lsp.buf.declaration()<CR>",
        desc = "",
      }
      keys[#keys + 1] = { "K", vim.lsp.buf.hover, desc = "Hover" }
      keys[#keys + 1] = {
        "<leader>lgi",
        "<cmd>lua vim.lsp.buf.implementation()<CR>",
        desc = "",
      }
      keys[#keys + 1] = {
        "<C-k>",
        vim.lsp.buf.signature_help,
        desc = "Signature Help",
        has = "signatureHelp",
      }
      keys[#keys + 1] = {
        "<leader>lwa",
        "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
        desc = "",
      }
      keys[#keys + 1] = {
        "<leader>lwr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        desc = "",
      }
      keys[#keys + 1] = {
        "<leader>lwl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        desc = "",
      }
      keys[#keys + 1] = {
        "<leader>ld",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        desc = "Type definition",
      }
      keys[#keys + 1] =
        { "<leader>lrn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "" }
      keys[#keys + 1] =
        { "<leader>lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "" }
      keys[#keys + 1] =
        { "<leader>lgr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "" }
      keys[#keys + 1] = {
        "<C-W>d",
        vim.diagnostic.open_float,
        desc = "Line Diagnostics",
      }
      keys[#keys + 1] = {
        "<C-W><C-D>",
        vim.diagnostic.open_float,
        desc = "Line Diagnostics",
      }
      keys[#keys + 1] =
        { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "" }
      keys[#keys + 1] =
        { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "" }
      keys[#keys + 1] = {
        "<leader>lq",
        "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>",
        desc = "",
      }
      keys[#keys + 1] =
        { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "" }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",
        "yapf",
        "cppdbg",
        "codelldb",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason.nvim", "rcarriga/nvim-dap-ui" },
    opts = function()
      local dap = require("dap")
      vim.print("in dap opts")
      local launchWithArgs = {
        args = function()
          local argument_string = vim.fn.input("Program arguments: ")
          return vim.fn.split(argument_string, " ", true)
        end,
        cwd = "${workspaceFolder}",
        name = "Launch file with arguments",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
          )
        end,
        request = "launch",
        stopOnEntry = true,
        type = "codelldb",
      }
      if not dap.configurations.cpp then
        dap.configurations.cpp = {
          launchWithArgs,
        }
      else
        vim.list_extend(dap.configurations.cpp, { launchWithArgs })
      end
    end,
  },
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        history = false,
        updateevents = "TextChanged,TextChangedI",
      })
      luasnip.config.setup({})
      for _, ft_path in
        ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true))
      do
        loadfile(ft_path)()
      end
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.SelectBehavior.Insert,
            select = true,
          }),
          ["<C-j>"] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "vim-dadbod-completion" },
        },
      })
      cmp.setup.filetype("sql", {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })
    end,
  },
  {
    "jakobkhansen/journal.nvim",
    command = "Journal",
    opts = {
      root = "./",
      date_format = "%d.%m.%Y",
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
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Grpc",
    ft = ".grpcurl",
  },
  -- {
  --   "gramic/tree-sitter-grpcurl",
  --   dev = true,
  --   dir = "~/work/tree-sitter-grpcurl", -- lazy = false,
  -- },
  {
    "echasnovski/mini.bracketed",
    enabled = false,
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    keys = {
      {
        "gS",
        "<cmd>lua MiniSplitjoin.toggle()<cr>",
        desc = "Mini SplitJoin toggle",
      },
    },
    dependencies = { "folke/which-key.nvim" },
    opts = {
      mappings = {
        toggle = "",
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = false,
      update_events = "TextChanged,TextChangedI",
      -- delete_check_events = "TextChanged",
    },
    build = (function()
      if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
        return
      end
      return "make install_jsregexp"
    end)(),
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
    ft = {
      "jsonnet",
      "cpp",
      "javascript",
      "bzl",
      -- "grpcurl",
    },
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
      -- require("gramic.soy-snippets")
      -- require("gramic.javascript-snippets")
      -- require("gramic.bzl-snippets")
      -- require("gramic.globals")
      require("gramic-bazel").setup(opts)
      -- require("grpcurl").setup(opts)
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
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    version = false,
    cmd = "Mason",
    opts = {
      log_level = vim.log.levels.DEBUG,
      ensure_installed = {
        "stylua",
        "stylelint-lsp",
        "jq-lsp",
        "shfmt",
        "pyright",
        "lua-language-server",
        "jsonnet-language-server",
        "yapf",
        "prettierd",
        "yq",
      },
      providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    -- dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(
          ".null-ls-root",
          ".neoconf.json",
          "Makefile",
          ".git"
        ),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettierd,
          -- nls.builtins.diagnostics.flake8,
          nls.builtins.formatting.yapf,
          nls.builtins.diagnostics.buildifier,
          nls.builtins.formatting.buildifier,
          nls.builtins.diagnostics.buf.with({
            disabled_filetypes = { "proto" },
          }),
          -- nls.builtins.diagnostics.codespell.with({
          --   disabled_filetypes = { "proto" },
          -- }),
          nls.builtins.diagnostics.tidy,
        },
      }
    end,
  },
  {
    "hudclark/grpc-nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "duganchen/vim-soy",
  {
    "moyiz/git-dev.nvim",
    event = "VeryLazy",
    opts = {},
  },
  "MisanthropicBit/decipher.nvim", -- provides base64-url-safe encoding/decoding
  "jamessan/vim-gnupg",
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        lazy = true,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- Add maktaba and codefmt to the runtimepath.
  -- {
  --   "google/vim-maktaba",
  -- },
  -- {
  --   "google/vim-codefmt",
  --   dependencies = { "google/vim-maktaba", "google/vim-glaive" },
  -- },
  -- {
  --   "google/vim-glaive",
  --   dependencies = { "google/vim-maktaba", "google/vim-codefmt" },
  --   lazy = false,
  --   -- command = "Glaive",
  --   config = function()
  --     vim.cmd([[Glaive codefmt clang_format_style=Google]])
  --   end,
  -- },
  { "google/vim-jsonnet" },
  {
    "vim-scripts/dbext.vim",
    command = "DBExecVisualSQL",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    opts = {
      highlight = { enable = true, disable = { "c_sharp" } },
      ensure_installed = {
        "vimdoc",
        "proto",
        "json",
        "sql",
        -- "grpcurl",
        "starlark",
        "javascript",
      },
    },
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
      {
        "isak102/telescope-git-file-history.nvim",
        dependencies = { "tpope/vim-fugitive" },
      },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
      if vim.fn.has("unix") == 1 then
        require("telescope").load_extension("git_file_history")
      end
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
            local path = require("oil").get_current_dir()
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
  -- {
  --   "tomtom/tcomment_vim",
  --   -- opts = {},
  -- },
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
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.editor.outline" },
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
