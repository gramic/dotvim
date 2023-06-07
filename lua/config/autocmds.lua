-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("gramic_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("autoformat_settings"),
  pattern = {
    "javascript",
    "cpp",
  },
  callback = function()
    vim.print("from callback of ft cpp")
    vim.b.autoformat = false
    vim.cmd([[AutoFormatBuffer clang-format]])
  end,
})
