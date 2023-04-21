local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {
  log_level = "info",
}

---@type LazyConfig
M.options = {}

-- Switch to terminal with C mark
function M._get_C_marked_terminal_buffer()
  local _, _, buffer, _ = unpack(vim.api.nvim_get_mark("C", {}))
  return buffer
end

-- Switch to terminal with C mark
function M._has_C_marked_terminal_buffer()
  return M._get_C_marked_terminal_buffer() ~= 0
end

-- Switch to terminal with C mark
function M._switch_to_terminal()
  local c_marked_buffer = M._get_C_marked_terminal_buffer()
  if not c_marked_buffer then
    return false
  end
  local winid = vim.fn.bufwinid(c_marked_buffer)
  vim.api.nvim_set_current_win(winid)
  return true
end

-- Find bazel running process, kill it first
-- and then rerun latest history command in terminal
function M.kill_bazel_and_restart_terminal()
  M.log.info("Kill bazel and restart terminal")
  if not M._has_C_marked_terminal_buffer() then
    M.log.info("No C marked terminal.")
    return false
  end
  local pid_of_bazel = vim.fn.system({ "pidof", "bazel" })
  if pid_of_bazel ~= "" then
    M.log.info("killing PID " .. pid_of_bazel .. " of bazel.")
    vim.fn.system("kill -9 " .. pid_of_bazel)
  else
    M.log.warn("PID of bazel is NOT found")
  end
  -- if not M._switch_to_terminal() then
  --   M.log.warn("Can't swtch to C marked terminal.")
  --   return false
  -- end
  M.log.info("vim.v.count = " .. vim.v.count .. ".")
  if vim.v.count == 0 then
    vim.cmd("TermExec cmd='!!'")
  else
    vim.cmd("TermExec cmd='!-" .. vim.v.count .. "'")
  end
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
  M.log = require("plenary.log").new({
    plugin = "gramic-bazel",
    level = M.options.log_level,
  })
end

return M
