local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {}

---@type LazyConfig
M.options = {}

function M.find_in_bazel_build()
  local fileName = vim.fn.expand("%:t")
  local dirName = vim.fn.expand("%:h")
  print("my file is " .. fileName)
  vim.fn.find({"BUILD", "BUILD.bazel"}, {path=dirName})
   vim.cmd("split %:h/BUILD*")
  vim.cmd("/" .. fileName)
end

--@param opts? LazyConfig
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
