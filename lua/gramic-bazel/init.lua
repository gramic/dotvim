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
    return -1
  end
  local winid = vim.fn.bufwinid(c_marked_buffer)
  if winid == -1 then
    vim.api.nvim_set_current_buf(c_marked_buffer)
    return 0
  end
  if vim.fn.bufexists(c_marked_buffer) then
    vim.api.nvim_set_current_win(winid)
  end
  return winid
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
    vim.fn.system("kill -15 " .. pid_of_bazel)
  else
    M.log.warn("PID of bazel is NOT found")
  end
  local terminal_winid = M._switch_to_terminal()
  if terminal_winid == -1 then
    M.log.warn("Can't switch to C marked terminal.")
    return false
  else
    if vim.api.nvim_win_get_height(terminal_winid) < 3 then
      vim.api.nvim_win_set_height(terminal_winid, 10)
    end
  end
  -- vim.api.nvim_win_get_height(window)
  local keys = ""
  if vim.v.count == 0 then
    keys = vim.api.nvim_replace_termcodes(
      "Gmai!!<CR><C-\\><C-n>G",
      true,
      false,
      true
    )
  else
    keys = vim.api.nvim_replace_termcodes(
      "Gmai!-" .. vim.v.count .. "<CR><C-\\><C-n>Gp",
      true,
      false,
      true
    )
  end
  vim.api.nvim_feedkeys(keys, "m", true)
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
