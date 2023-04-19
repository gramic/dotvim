local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {}

---@type LazyConfig
M.options = {}

-- Switch to terminal with C mark
function M._switch_to_terminal()
  local _, _, buffer, _ = unpack(vim.api.nvim_get_mark("C", {}))
  if not buffer then
    return false
  end
  local winid = vim.fn.bufwinid(buffer)
  vim.api.nvim_set_current_win(winid)
  return true
end

-- Find bazel running process, kill it first
-- and then rerun latest history command in terminal
function M.kill_bazel_and_restart_terminal()
  if not M._switch_to_terminal() then
    print("Start a new terminal and mark it with capital C")
    return false
  end
  local pid_of_bazel = vim.fn.system({ "pidof", "bazel" })
  if pid_of_bazel ~= "" then
    print("pid_of_bazel is " .. pid_of_bazel)
    vim.fn.system("kill -9 " .. pid_of_bazel)
  else
    print("pid_of_bazel is NOT found")
  end
  -- vim.cmd("'Ci<up><enter>mamCG")
  vim.cmd("i<up><enter>mamCG")
end

function M.split_build_file(build_file_path, search_file_name)
  vim.cmd("split " .. build_file_path)
  vim.cmd("/" .. search_file_name)
end

function M.find_in_bazel_build()
  local base_name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
  local dir_name = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  local build_files = vim.fs.find({ "BUILD.bazel", "BUILD" }, {
    upward = true,
    stop = vim.loop.os_homedir(),
    limit = 1,
    path = dir_name,
    type = "file",
  })
  local found = build_files[1]
  if found == nil then
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
