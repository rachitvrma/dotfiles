-- Dropbar is the winbar that gives a IDE like experience

-- NOTE: Dropbar gives the option of replacing vim.ui.select with it's own ui
-- but don't do that, since snacks.picker already uses that.

local dropbar_api = require('dropbar.api')
vim.keymap.set(
  'n',
  '<Leader>;',
  dropbar_api.pick,
  { desc = 'Pick symbols in winbar' }
)
vim.keymap.set(
  'n',
  '[;',
  dropbar_api.goto_context_start,
  { desc = 'Go to start of current context' }
)
vim.keymap.set(
  'n',
  '];',
  dropbar_api.select_next_context,
  { desc = 'Select next context' }
)
