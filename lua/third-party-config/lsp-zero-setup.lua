local cmp = require('cmp')
local luasnip = require('luasnip')
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true)
})
lsp.configure('sumneko_lua', {
  -- flags = {
  --   debounce_text_changes = 150,
  -- },
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'R', 'P'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   client.resolved_capabilities.document_formatting = false
  -- end
})
lsp.configure('clangd', {})
local mapping = {
  ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<S-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  -- go to next placeholder in the snippet
  ['<C-j>'] = cmp.mapping(function(fallback)
    if luasnip.jumpable(1) then
      luasnip.jump(1)
    else
      fallback()
    end
  end, {'i', 's'}),
  -- go to previous placeholder in the snippet
  ['<C-k>'] = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {'i', 's'}),
  ['<C-e>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  -- Accept currently selected item. If none selected, `select` first item.
  -- Set `select` to `false` to only confirm explicitly selected items.
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
}
lsp.setup_nvim_cmp({
    mapping = mapping,
    completion = {
      autocomplete = false,
    },
    experimental = {
      ghost_text = true -- this feature conflict to the copilot.vim's preview.
    },
  })

-- P(lsp.defaults.cmp_mappings())
lsp.setup()
