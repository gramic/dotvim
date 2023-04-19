local M = {}

---@type LazySpecLoader
M.spec = nil

---@class LazyConfig
M.defaults = {}

---@type LazyConfig
M.options = {}

function M._find_terminal_in_current_tab()
  local planetary = require("planetary.busted")
  local tab_buffers = vim.fn.tabpagebuflist()
  for _, bufnr in pairs(tab_buffers) do
    local buffer_name = vim.fn.bufname(bufnr)
    print("buffer_name: " .. buffer_name)
    planetary.print(bufnr)
    print("bufnr: " .. bufnr)
    --   -- local winid = vim.fn.bufwinid(bufnr)
    --   local buffer_name = vim.fn.bufname(bufnr)
    --   if vim.startswith(buffer_name, "term:") then
    --     print("term: " .. buffer_name)
    --     -- local wininfo_list = vim.fn.getwininfo(winid)
    --     -- for _, wininfo in ipairs(wininfo_list) do
    --     --   -- print("wininfo: " .. wininfo)
    --     --   if wininfo.terminal == 1 then
    --     --     print("terminal is winid: " .. bufnr)
    --     --     -- return bufnr
    --     --   else
    --     --     print("not a terminal: " .. bufnr)
    --     --   end
    --     -- end
    --   end
  end
  -- return -1
end

-- Find bazel running process, kill it first
-- and then rerun latest history command in terminal
function M.kill_bazel_and_restart_terminal()
  local terminal_bufnr = M._find_terminal_in_current_tab()
  print("terminal_bufnr is " .. terminal_bufnr)
  local pid_of_bazel = vim.fn.system({ "pidof", "bazel" })
  if pid_of_bazel ~= "" then
    print("pid_of_bazel is " .. pid_of_bazel)
    vim.fn.system("kill -9 " .. pid_of_bazel)
  else
    print("pid_of_bazel is NOT found")
  end
  -- vim.cmd("'Ci<up><enter>mamCG")
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
