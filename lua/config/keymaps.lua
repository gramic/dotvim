-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- map("n", "<leader>bb")

local map = vim.keymap.set

vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

-- bazel
local bazel = require("bazel")
local my_bazel = require("config.bazel")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "bzl",
  callback = function()
    map(
      "n",
      "gd",
      vim.fn.GoToBazelDefinition,
      { buffer = true, desc = "Goto Definition" }
    )
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "bzl",
  callback = function()
    map("n", "<Leader>y", my_bazel.YankLabel, { desc = "Bazel Yank Label" })
  end,
})
map("n", "gbt", vim.fn.GoToBazelTarget, { desc = "Goto Bazel Build File" })
map("n", "<Leader>bl", bazel.run_last, { desc = "Bazel Last" })
map("n", "<Leader>bdt", my_bazel.DebugTest, { desc = "Bazel Debug Test" })
map("n", "<Leader>bdr", my_bazel.DebugRun, { desc = "Bazel Debug Run" })
map("n", "<Leader>bt", function()
  bazel.run_here("test", vim.g.bazel_config)
end, { desc = "Bazel Test" })
-- map("n", "<Leader>bb", function()
--   bazel.run_here("build", vim.g.bazel_config)
-- end, { desc = "Bazel Build" })
map("n", "<Leader>br", function()
  bazel.run_here("run", vim.g.bazel_config)
end, { desc = "Bazel Run" })
map("n", "<Leader>bdb", function()
  bazel.run_here(
    "build",
    vim.g.bazel_config .. " --compilation_mode dbg --copt=-O0"
  )
end, { desc = "Bazel Debug Build" })
map(
  "n",
  "<Leader>bda",
  my_bazel.set_debug_args_from_input,
  { desc = "Set Bazel Debug Arguments" }
)
-- Clear search with <esc>
map(
  { "i", "n" },
  "<esc>",
  "<cmd>noh<cr><esc>",
  { desc = "Escape and clear hlsearch" }
)
