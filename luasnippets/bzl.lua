-- Requires {{{
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local extras = require("luasnip.extras")
local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt
--}}}

return {
  s({trig="cc_all", dscr = "Create cc_library with cc_trest with tests and empty files."},
    fmt(
      [[
        cc_library(
            name = "{}",
            srcs = ["{}"],
            hdrs = ["{}"],
        )


        cc_test(
            name = "{}",
            size = "small",
            srcs = ["{}"],
            deps = ["
                ":{}",
                "@boost_di",
                "@org_boost_ut",
            ],
        )

        {}
      ]],
      {
        i(1),
        l(l._1 .. ".cc", 1),
        l(l._1 .. ".h", 1),
        l(l._1 .. "_test", 1),
        l(l._1 .. "_test.cc", 1),
        l(l._1, 1),
        i(0),
      }
    ),
    {}
  ),

  s({trig="cc_library", dscr = "Create cc_library only."},
    fmt(
      [[
        cc_library(
            name = "{}",
            srcs = ["{}"],
            hdrs = ["{}"],
        ){}
      ]],
      {
        i(1),
        l(l._1 .. ".cc", 1),
        l(l._1 .. ".h", 1),
        i(0),
      }
    ),
    {}
  )
}
