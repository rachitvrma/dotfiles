-- Lazydev setup
require('lazydev').setup({
  library = {
    { path = vim.g.luvit_meta_path .. '/library', words = { 'vim%.uv' } },
  },
})

-- Global config applied to ALL servers before they start
vim.lsp.config('*', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- Merge extra capabilities needed specifically by markdown-oxide
-- Order matters, so it must be before vim.lsp.enable
vim.lsp.config('markdown_oxide', {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }
  ),
})

-- Override nixd's default cmd to enable semantic tokens (better tree-sitter-esque highlighting)
vim.lsp.config('nixd', {
  cmd = { 'nixd', '--semantic-tokens' },
})

vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

-- Enable each server — Neovim matches filetype → starts server → done
vim.lsp.enable({
  'jsonls',
  'lua_ls',
  'nixd',
  'markdown_oxide',
  'mpls',
  'tombi', -- For toml
  'clangd', -- For c/c++
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local map = function(k, f) vim.keymap.set('n', k, f, { buffer = args.buf }) end

    -- Things not yet in defaults
    map('gd', vim.lsp.buf.definition) -- CTRL-] does this too
    map('gD', vim.lsp.buf.declaration)
    map('<leader>d', vim.diagnostic.open_float) -- show diagnostic in float
  end,
})

vim.diagnostic.config({
  virtual_text = true, -- inline error text
  signs = true,
  underline = true,
  update_in_insert = false, -- don't distract while typing
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true, -- show which LSP is reporting
  },
})
