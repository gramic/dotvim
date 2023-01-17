return {
  s({trig="cc_all", dscr = "Create all kind of library with tests."}, {
    t({"cc_library("}),
    t({"", "    name = \""}), i(1), t({"\""}),
    t({"", "    srcs = [\""}), l(l._1 .. ".cc", 1), t({"\"]"}),
    t({"", "    hdrs = [\""}), l(l._1 .. ".h", 1), t({"\"]"}),
    t({"", ")"}),
    t({"", ""}),
    t({"", ""}),
    t({"cc_test("}),
    t({"", "    name = \""}), l(l._1 .. "_test", 1), t({"\""}),
    t({"", "    size = \"small\""}),
    t({"", "    srcs = [\""}), l(l._1 .. "_test.cc", 1), t({"\"]"}),
    t({"", "    deps = [\""}),
    t({"", "        \":"}), l(l._1, 1), t({"\""}),
    t({"", "        \"@boost_di\""}),
    t({"", "        \"@org_boost_ut\""}),
    t({"", "    ]"}),
    t({"", ")"})
  })
}
