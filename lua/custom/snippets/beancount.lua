require("luasnip.session.snippet_collection").clear_snippets("beancount")

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

---Returns the date of the previous transaction
---@return string
local get_previous_transaction_node_date = function()
  local last_date = os.date("%Y-%m-%d") .. ""
  local cursor_row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  ---@type TSTree[]
  local ts_tree =
    vim.treesitter.get_parser():parse({ cursor_row, cursor_row - 100 })
  local query = vim.treesitter.query.parse(
    "beancount",
    [[ (transaction date: (date) @date) ]]
  )
  local date_captures = query:iter_captures(ts_tree[1]:root(), 0)
  ---TSNode?
  local last_date_node = nil
  for _, node, _ in date_captures do
    if node ~= nil then
      last_date_node = node
    end
  end
  if last_date_node ~= nil then
    last_date = vim.treesitter.get_node_text(last_date_node, 0)
  end
  return last_date
end

--- Return via tree-sitter what params the curent function has
---@return table<string, string>
local choice_existing_params = function(position)
  return d(position, function()
    ---@type TSNode[]
    local nodes = {}
    ---@type string
    local prev_date = get_previous_transaction_node_date()
    table.insert(nodes, t(prev_date))
    return sn(nil, c(1, nodes))
  end, {})
end

local rec_ls
rec_ls = function()
  return sn(nil, {
    c(1, {
      -- important!! Having the sn(...) as the first choice will cause infinite recursion.
      t({ "" }),
      -- The same dynamicNode as in the snippet (also note: self reference).
      sn(nil, { t({ "", "{} {} BGN" }), i(1), d(2, rec_ls, {}) }),
    }),
  })
end

ls.add_snippets("beancount", {
  s(
    {
      trig = "[tд]",
      dscr = "Create expense with today's date.",
    },
    fmt(
      [[
        {} * "{}"
          {} {} BGN
          {}
        {}
      ]],
      {
        i(1, os.date("%Y-%m-%d")),
        i(2),
        i(3),
        d(4, rec_ls, {}),
        i(5, "Активи:KBC:Основна"),
        i(0),
      }
    ),
    {}
  ),

  s(
    {
      trig = "[npсп]", -- [n]ext, [p]revious, [с]ледващ, [п]редишен
      trigEngine = "vim",
      dscr = "Create expense with previous post date.",
    },
    fmt(
      [[
        {} * "{}"
          {} {} BGN
          {}
        {}
      ]],
      {
        choice_existing_params(1),
        i(2),
        i(3),
        d(4, rec_ls, {}),
        i(5, "Активи:KBC:Основна"),
        i(0),
      }
    ),
    {}
  ),
})
