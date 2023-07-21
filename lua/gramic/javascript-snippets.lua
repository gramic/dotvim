local ts_query = require("vim.treesitter.query")
local ts_languagetree = require("vim.treesitter.languagetree")
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

---@param function_declaration_node TSNode
local get_function_declaration_parameter_names = function(
  function_declaration_node
)
  return "param111"
end

local get_existing_argument = function(position)
  return d(position, function()
    local parser = vim.treesitter.get_parser()
    ---@type LanguageTree
    local tree = parser:parse()
    ---@type TSTree
    local root = tree[1]:root()
    local nodes = {}
    ---@type TSNode|nil
    local current_node = vim.treesitter.get_node()
    if current_node == nil then
      table.insert(nodes, t("example"))
    elseif current_node:type() == "comment" then
      local function_declaration_node = current_node:next_named_sibling()
      if function_declaration_node:type() == "function_declaration" then
        table.insert(
          nodes,
          t(get_function_declaration_parameter_names(function_declaration_node))
        )
        table.insert(nodes, t("example3333"))
      end
    end
    return sn(nil, c(1, nodes))
  end, {})
end

ls.add_snippets("javascript", {
  s("@private", {
    t({ "/**", " * @private", " */", "" }),
    i(1),
    t({ "() {", "" }),
    t({ "  " }),
    i(0),
    t({ "", "}", "" }),
  }),
  s("@private", {
    -- with one param
    t({ "/**", " * @private", "" }),
    t(" * @param {"),
    i(1, { "type" }),
    t("} "),
    i(2, { "name" }),
    t(" "),
    i(3, { "Documentation" }),
    t({ "", " */", "" }),
    i(4, { "f" }),
    t({ "() {", "" }),
    t({ "  " }),
    i(0),
    t({ "", "}", "" }),
  }),
  s("@param", {
    t("@param {"),
    i(1, "type"),
    t("} "),
    get_existing_argument(2),
    t(" "),
    i(0),
  }),
})
