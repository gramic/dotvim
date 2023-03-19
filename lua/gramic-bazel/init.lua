local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {}

---@type LazyConfig
M.options = {}

function M.split_build_file(build_file_path, search_file_name)
    vim.cmd("split " .. build_file_path)
    vim.cmd("/" .. search_file_name)
end

function M.find_in_bazel_build()
  local base_name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
  local dir_name = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  local build_files = vim.fs.find(
    {"BUILD.bazel", "BUILD"},
    {
      upward = true,
      stop = vim.loop.os_homedir(),
      limit = 1,
      path = dir_name,
      type = "file",
    }
  )
  local found = build_files[1]
  if (found == nil) then
    print("BUILD file not found")
  else
    M.split_build_file(found, base_name)
  end
end

--@param opts? LazyConfig
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
