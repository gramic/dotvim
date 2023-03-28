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
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
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
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = true,
      },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      require("lazyvim.plugins.lsp.format").autoformat = opts.autoformat
      -- setup formatting and keymaps
      require("lazyvim.util").on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)
      -- diagnostics
      for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)
      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local available = have_mason and mlsp.get_available_servers() or {}

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if
            server_opts.mason == false
            or not vim.tbl_contains(available, server)
          then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed })
        mlsp.setup_handlers({ setup })
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "pyright",
        "flake8",
      },
      providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
