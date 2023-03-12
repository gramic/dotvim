local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {}

---@type LazyConfig
M.options = {}

function M.find_in_bazel_build()
  local file_name = vim.fn.expand("%:t")
  local dir_name = vim.fn.expand("%:h")
  print("my file_name is " .. file_name)
  print("my dir_name is " .. dir_name)
  local build_files = vim.fs.find(
    {"BUILD.bazel", "BUILD"},
    {
      path = './' .. dir_name .. '/',
      type = "file",
    }
  )
  if (build_files[0] == nil) then
    print("BUILD file not found")
  else
    vim.cmd("split " .. build_files[0])
    vim.cmd("/" .. file_name)
  end
end

--@param opts? LazyConfig
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
