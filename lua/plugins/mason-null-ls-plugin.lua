return {
  {
    "jay-babu/mason-null-ls.nvim",
    -- event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "ruff",
      },
    },
    config = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {},
        {
          null_ls.builtins.diagnostics.buildifier,
          null_ls.builtins.formatting.buildifier,
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.protoc_gen_lint,
          null_ls.builtins.diagnostics.sqlfluff,
          null_ls.builtins.diagnostics.tidy,
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.shellharden,
          null_ls.builtins.diagnostics.selene,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.codespell,
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "html", "css", "yaml", "markdown", "json" },
          }),
          null_ls.builtins.formatting.yapf.with({
          }),
        })
      null_ls.setup(opts)
    end,
  },
}
