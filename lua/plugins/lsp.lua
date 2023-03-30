return {
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gt", false }
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
      keys[#keys + 1] =
        { "<leader>le", vim.diagnostic.open_float, desc = "Line Diagnostics" }
      keys[#keys + 1] =
        { "<leader>l[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "" }
      keys[#keys + 1] =
        { "<leader>l]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "" }
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
    "neovim/nvim-lspconfig",
    version = false,
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      -- diagnostics = {
      --   underline = true,
      --   update_in_insert = false,
      --   virtual_text = { spacing = 4, prefix = "●" },
      --   severity_sort = true,
      -- },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      -- format = {
      --   formatting_options = nil,
      --   timeout_ms = nil,
      -- },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        clangd = {},
        jsonnet_ls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
                disable = { "lowercase-global" },
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- lua_ls = function(_, opts)
        --   require("lua_ls").setup({ settings = opts.settings })
        --   return true
        -- end,
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    version = false,
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "pyright",
        "flake8",
        "lua-language-server",
      },
      providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
      },
    },
  },
}
