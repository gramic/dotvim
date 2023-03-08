return {

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
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
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
      -- opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
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
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
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
	-- 	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
