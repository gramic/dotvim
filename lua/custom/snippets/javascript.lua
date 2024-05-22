require("luasnip.session.snippet_collection").clear_snippets("javascript")
-- local ts_query = require("vim.treesitter.query")
-- local ts_languagetree = require("vim.treesitter.languagetree")
-- local ts_utils = require("nvim-treesitter.ts_utils")
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

---Returns index of the @param in the jsdoc comment
---@param comment_node TSNode
---@return integer
local get_current_param_index_in_jsdoc = function(comment_node)
  local query = vim.treesitter.query.parse(
    "jsdoc",
    [[
((tag_name) @tag_name (#eq? @tag_name "@param"))
]]
  )
  local comment_text = vim.treesitter.get_node_text(comment_node, 0, nil)
  local jsdoc_parser =
    vim.treesitter.get_string_parser(comment_text, "jsdoc", nil)
  ---@type TSTree[]
  local ts_tree = jsdoc_parser:parse()
  local root_node = ts_tree[1]:root()
  local start, _, stop, _ = vim.treesitter.get_node_range(root_node)
  local bufnr = 0 -- current buffer
  local param_captures = query:iter_captures(root_node, bufnr, start, stop)
  local index = 0
  for id, node, _ in param_captures do
    local name = query.captures[id]
    if name == "tag_name" then
      local is_current_snippet = node:parent():child_count() < 2
      if is_current_snippet then
        return index + 1
      else
        index = index + 1
      end
    end
  end
  return 0
end

---@param function_declaration_node TSNode
---@return string[]
local get_function_declaration_parameter_names = function(
  function_declaration_node
)
  local params = {}
  local query = vim.treesitter.query.parse(
    "javascript",
    [[
(
 function_declaration
   parameters: (
     formal_parameters (identifier) @param
     )
 )
   ]]
  )
  local start, _, stop, _ =
    vim.treesitter.get_node_range(function_declaration_node)
  local bufnr = 0 -- current buffer
  local param_captures =
    query:iter_captures(function_declaration_node, bufnr, start, stop)
  for id, node, _ in param_captures do
    local name = query.captures[id]
    if name == "param" then
      local node_text = vim.treesitter.get_node_text(node, 0, nil)
      table.insert(params, node_text)
    end
  end
  return params
end

--- Return via tree-sitter what params the curent function has
---@return table<string, string>
local choice_existing_params = function(position)
  return d(position, function()
    ---@type TSNode[]
    local nodes = {}
    ---@type TSNode|nil
    local current_node = vim.treesitter.get_node({ ignore_injection = false })
    if current_node == nil then
      table.insert(nodes, t("example"))
    elseif current_node:type() == "comment" then
      local jsdoc_param_index = get_current_param_index_in_jsdoc(current_node)
      local function_declaration_node = current_node:next_named_sibling()
      if function_declaration_node:type() == "function_declaration" then
        local params =
          get_function_declaration_parameter_names(function_declaration_node)
        if #params == 0 then
          return sn(nil, t(""))
        end
        if
          jsdoc_param_index > 0
          and #params >= 0
          and #params >= jsdoc_param_index
        then
          table.insert(nodes, t(params[jsdoc_param_index]))
        else
          for _, param_name in pairs(params) do
            table.insert(nodes, t(param_name))
          end
        end
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
    i(1),
    t("} "),
    choice_existing_params(2),
    t(""),
    i(0),
  }),
})
