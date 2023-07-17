-- Requires {{{
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt
--}}}

return {
  s(
    {
      trig = "@private",
      dscr = "Create private member function.",
    },
    fmt(
      [[
        /**
         * @private
         */
         {}() [
           {}
         ]
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
}
