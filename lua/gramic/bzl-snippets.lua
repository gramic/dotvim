local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
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

ls.add_snippets("bzl", {
  s(
    {
      trig = "cc_all",
      dscr = "Create cc_library with cc_test with tests and empty files.",
    },
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
            deps = [
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

  s(
    { trig = "cc_library", dscr = "Create cc_library only." },
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
  ),

  s(
    {
      trig = "js_all",
      dscr = "Create js_library with cc_test with tests and empty files.",
    },
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
            deps = [
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
})
