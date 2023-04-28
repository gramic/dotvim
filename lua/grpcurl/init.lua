local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {
  log_level = "info",
}

---@type LazyConfig
M.options = {}

function M.config_parser()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.grpcurl = {
    install_info = {
      url = "~/work/tree-sitter-grpcurl", -- local path or git repo
      files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
      -- optional entries:
      -- branch = "main", -- default branch in case of git repo if different from master
      -- generate_requires_npm = false, -- if stand-alone parser without npm dependencies
      -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "grpcurl", -- if filetype does not match the parser name
  }
end

--@param opts? LazyConfig
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
  M.log = require("plenary.log").new({
    plugin = "grpcurl",
    level = M.options.log_level,
  })
  vim.treesitter.language.register("grpcurl", "someft")
  vim.filetype.add({ extension = { grpcurl = "grpcurl" } })
  M.config_parser()
end

return M
