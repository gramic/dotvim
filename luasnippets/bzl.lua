-- Requires {{{
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
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
  )
}

-- return {
--   s({trig="cc_all", dscr = "Create cc_library with cc_trest with tests and empty files."}, {
--     t({"cc_library("}),
--     t({"", "    name = \""}), i(1), t({"\""}),
--     t({"", "    srcs = [\""}), l(l._1 .. ".cc", 1), t({"\"]"}),
--     t({"", "    hdrs = [\""}), l(l._1 .. ".h", 1), t({"\"]"}),
--     t({"", ")"}),
--     t({"", ""}),
--     t({"", ""}),
--     t({"cc_test("}),
--     t({"", "    name = \""}), l(l._1 .. "_test", 1), t({"\""}),
--     t({"", "    size = \"small\""}),
--     t({"", "    srcs = [\""}), l(l._1 .. "_test.cc", 1), t({"\"]"}),
--     t({"", "    deps = [\""}),
--     t({"", "        \":"}), l(l._1, 1), t({"\""}),
--     t({"", "        \"@boost_di\""}),
--     t({"", "        \"@org_boost_ut\""}),
--     t({"", "    ]"}),
--     t({"", ")"})
--   })
-- }
