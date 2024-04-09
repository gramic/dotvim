--!strict

--[[ Generate a date and place it at current cursor position ]]
local insert_date = function()
  -- Get row and column cursor,
  -- use unpack because it's a tuple.
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  --@type string
  local date = os.date("[%d.%m.%Y at %H:%M] ")
  if col > 0 then
    date = os.date("%d.%m.%Y %A")
  end
  -- Notice the date is given as an array parameter, you can pass multiple strings.
  -- Params 2-5 are for start and end of row and columns.
  -- See earlier docs for param clarification or `:help nvim_buf_set_text.
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { date })
  vim.api.nvim_win_set_cursor(0, { row, col + string.len(date) })
end

vim.keymap.set({ "n", "i" }, "<M-;>", function()
  vim.print("this is some date" .. os.date("%d.%m.%Y %A"))
  insert_date()
end)
