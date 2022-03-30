local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.diagnostics.buildifier,
  null_ls.builtins.formatting.buildifier,
  null_ls.builtins.diagnostics.hadolint,
  null_ls.builtins.diagnostics.protoc_gen_lint,
  null_ls.builtins.diagnostics.sqlfluff
}

null_ls.setup({ sources = sources })
