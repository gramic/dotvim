local lsp_installer = require("nvim-lsp-installer")


local opts = { noremap=true, silent=true }
-- Register a handler that will be called for each installed server
-- when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  if server.name == "sumneko_lua" then
    opts = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'P' },
          },
        },
      },
    }
  else
    opts = {}
  end
  opts.on_attach = function (_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.keymap.set('n', '<leader>lk', vim.diagnostic.goto_prev, {buffer = bufnr})
    vim.keymap.set('n', '<leader>lj', vim.diagnostic.goto_next, {buffer = bufnr})
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {buffer = bufnr})
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {buffer = bufnr})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer = bufnr})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = bufnr})
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {buffer = bufnr})
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {buffer = bufnr})
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {buffer = bufnr})
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer = bufnr})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer = bufnr})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer = bufnr})
    vim.keymap.set('n', '<leader>gf', vim.diagnostic.goto_next, {buffer = bufnr})
  end
  server:setup(opts)
end)
