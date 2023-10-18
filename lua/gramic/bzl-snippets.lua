local ls = require("luasnip")
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
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

local function query_require()
  return "ahaa from query_require"
end

local f_node = f(query_require)

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
        closure_js_library(
            name = "{}",
            srcs = ["{}"],
        )

        closure_js_test(
            name = "{}",
            size = "small",
            srcs = ["{}"],
            deps = [
                ":{}",
            ],
        )
        {}
      ]],
      {
        i(1),
        l(l._1 .. ".js", 1),
        l(l._1 .. "_test", 1),
        l(l._1 .. "_test.js", 1),
        l(l._1, 1),
        i(0),
      }
    ),
    {}
  ),

  s(
    {
      trig = "closure_js_library",
      dscr = "Create js_library with cc_test with tests and empty files.",
    },
    fmt(
      [[
        closure_js_library(
            name = "{}",
            srcs = ["{}"],
            deps = [
                ":{}",
            ],
        )
        {}
      ]],
      {
        i(1),
        l(l._1 .. ".js", 1),
        i(2),
        i(0),
      }
    ),
    {}
  ),

  s({
    trig = "public",
    dscr = "Create public access for the targets in this package.",
  }, t('package(default_visibility = ["//visibility:public"])'), {}),

  s(
    {
      trig = "load",
      dscr = "Load library.",
    },
    fmt(
      [[
        load({}, {})
        {}
      ]],
      {
        c(1, {
          t('"@io_bazel_rules_closure//closure:defs.bzl"'),
          t('"somethng.bzl"'),
        }),
        i(2),
        i(0),
      }
    )
  ),

  s(
    {
      trig = "py_all",
      dscr = "Create py_library with py_test with tests and empty files.",
    },
    fmt(
      [[
        py_library(
            name = "{}",
            srcs = ["{}"],
            deps = [],
        )

        py_test(
            name = "{}",
            size = "small",
            srcs = ["{}"],
            deps = [
                ":{}",
                "@abseil-py//absl/logging",
                "@abseil-py//absl/testing:absltest",
            ],
        )
        {}
      ]],
      {
        i(1),
        l(l._1 .. ".py", 1),
        l(l._1 .. "_test", 1),
        l(l._1 .. "_test.py", 1),
        l(l._1, 1),
        i(0),
      }
    ),
    {}
  ),

  s(
    { trig = "py_library", dscr = "Create py_library only." },
    fmt(
      [[
        py_library(
            name = "{}",
            srcs = ["{}"],
            deps = [
              "@abseil-py//absl/logging",
            ],
        ){}
      ]],
      {
        i(1),
        l(l._1 .. ".py", 1),
        i(0),
      }
    ),
    {}
  ),
})
