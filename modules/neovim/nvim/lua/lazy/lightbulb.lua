return {
  'nvim-lightbulb',
  event = 'LspAttach',
  after = function()
    require('nvim-lightbulb').setup({
      autocmd = { enabled = true },
    })
  end,
}
