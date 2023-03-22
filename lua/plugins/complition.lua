return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
            and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c",
          }),
        }),
        sources = cmp.config.sources(vim.list_extend(opts.sources, {
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        })),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local source_names = {
              nvim_lsp = "(LSP)",
              path = "(Path)",
              luasnip = "(Snippet)",
              buffer = "(Buffer)",
            }
            local duplicates = {
              buffer = 1,
              path = 1,
              nvim_lsp = 0,
              luasnip = 1,
            }
            local duplicates_default = 0
            -- item.kind = icons.kind[item.kind]
            item.menu = source_names[entry.source.name]
            item.dup = duplicates[entry.source.name] or duplicates_default
            return item
          end,
        },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and
              "<Plug>luasnip-jump-next" or
              "<tab>"
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = "i",
      },
      {
        "<tab>",
        function() require("luasnip").jump(1) end,
        mode = "s"
      },
      {
        "<s-tab>",
        function() require("luasnip").jump(-1) end,
        mode = { "i", "s" }
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
    -- opts = {
    --   -- sources = {
    --   --   null_ls.builtins.formatting.stylua,
    --   --   null_ls.builtins.diagnostics.ruff.with({
    --   --     extra_args = { "--max-line-length=80" },
    --   --   }),
    --   -- },
    --   ensure_installed = {
    --     "stylua",
    --     "shellcheck",
    --     "shfmt",
    --     "flake8",
    --     "ruff",
    --   },
    -- }
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1200
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      {
        "<leader>cs",
        "<cmd>SymbolsOutline<cr>",
        desc = "Symbols Outline",
      },
    },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = {}
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "cpp",
        "sql",
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      autotag = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = { "c", "rust" },
        -- Setting this to true will run `:h syntax` and tree-sitter at the
        -- same time.
        -- Set this to `true` if you depend on 'syntax' being enabled
        -- (like for indentation).
        -- Using this option may slow down your editor,
        -- and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-backspace>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
    },
  },

  --  {
  --   comparators = {
  --       cmp.config.compare.offset,
  --       cmp.config.compare.exact,
  --       cmp.config.compare.recently_used,
  --       require("clangd_extensions.cmp_scores"),
  --       cmp.config.compare.kind,
  --       cmp.config.compare.sort_text,
  --       cmp.config.compare.length,
  --       cmp.config.compare.order,
  --   },
  --   mapping = cmp.mapping.preset.insert({
  -- 	['<C-b>'] = cmp.mapping.scroll_docs(-4),
  -- 	['<C-f>'] = cmp.mapping.scroll_docs(4),
  -- 	['<C-Space>'] = cmp.mapping.complete(),
  -- 	['<C-e>'] = cmp.mapping.abort(),
  -- 	['<CR>'] = cmp.mapping.confirm({ select = true }),
  -- --	Accept currently selected item.
  -- --	Set `select` to `false` to only confirm explicitly selected items.
  --       }),
  --   snippet = {
  --     expand = function(args)
  --       require('luasnip').lsp_expand(args.body)
  --     end,
  --   },
  --   sources = cmp.config.sources({
  --     { name = 'nvim_lsp' },
  --     { name = 'luasnip' }, -- For luasnip users.
  --     -- { name = 'vsnip' }, -- For vsnip users.
  --     -- { name = 'ultisnips' }, -- For ultisnips users.
  --     -- { name = 'snippy' }, -- For snippy users.
  --   }, {
  --     { name = 'buffer' },
  --   })
  -- }
}
