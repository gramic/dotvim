local M = {}

---@class LazyConfig
M.defaults = {}

---@type LazyConfig
M.options = {}

function M.find_in_bazel_build()
  local fileName = vim.fn.expand("%:t")
  print("my file is " .. fileName)
  vim.cmd("split %:h/BUILD*")
  vim.cmd("/" .. fileName)
end

--@param opts? LazyConfig
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
