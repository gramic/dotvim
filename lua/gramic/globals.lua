P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

vim.keymap.set('n', '<leader><leader>x', '<cmd>w<cr><cmd>source %<cr>')
