return {
  {
    "neovim/nvim-lspconfig",
  },

  {
    "williamboman/mason.nvim",
    version = false,
    dependencies = { 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'williamboman/mason.nvim' },
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "jsonnet_ls",
        "pyright",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
      local on_attach = function(client, bufnr)
        local buf_set_keymap = vim.keymap.set
        local opts = { noremap = true, silent = true, buffer = bufnr }
        if client.name == 'omnisharp' then
          buf_set_keymap('n', 'gd', '<Cmd>lua require("omnisharp_extended").lsp_definitions()<CR>', opts)
        else
          buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        end
        buf_set_keymap('n', '<leader>lgd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        buf_set_keymap('n', '<leader>l[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', '<leader>l]d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
      end
      local rounded_border_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }
      local lua_runtime_path = vim.split(package.path, ';')
      table.insert(lua_runtime_path, "lua/?.lua")
      table.insert(lua_runtime_path, "lua/?/init.lua")
      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig').lua_ls.setup {
        on_attach = on_attach,
        handlers = rounded_border_handlers,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = lua_runtime_path,
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        }
      }

      require('lspconfig').jsonnet_ls.setup {
        ext_vars = {
          foo = 'bar',
        },
        on_attach = on_attach,
        capabilities = capabilities,
      }

      require 'lspconfig'.pyright.setup {}

      -- require'lspconfig'.starlark_rust.setup{}
    end
  },
}
