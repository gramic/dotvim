return {
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
          nls.builtins.diagnostics.protoc_gen_lint.with({
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
}
