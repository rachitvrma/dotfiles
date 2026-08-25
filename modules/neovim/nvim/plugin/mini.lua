do
  require('mini.statusline').setup()
  require('mini.surround').setup()
  require('mini.pairs').setup()

  -- Autocompletion
  require('mini.snippets').setup()

  -- Enable Mini.completion
  require('mini.completion').setup({
    window = {
      info = { borders = 'single' },
      signature = { borders = 'single' },
    },
  })

  -- From MiniCompletion's Documentation
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })

  -- Configure mini.sessions
  require('mini.sessions').setup()
end
