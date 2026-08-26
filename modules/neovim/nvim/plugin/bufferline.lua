do
  local bufferline = require('bufferline')
  bufferline.setup({
    options = {
      separator_style = 'padded_slant', -- 'slant' | 'slope' | 'thick' | 'thin' | { 'any', 'any' },

      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },

      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'snacks_layout_box',
          text = '󰙅  File Explorer',
          -- text_align = 'left',
          separator = true,
        },
      },
    },
  })

  -- Bufferline keymaps
  Snacks.keymap.set(
    'n',
    '<leader>bb',
    function() require('bufferline').pick() end,
    { desc = 'Pick buffer' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bd',
    function() Snacks.bufdelete() end,
    { desc = 'Delete buffer' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bD',
    function() require('bufferline').close_with_pick() end,
    { desc = 'Pick buffer to close' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bo',
    function() require('bufferline').close_others() end,
    { desc = 'Close other buffers' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bn',
    function() require('bufferline').cycle(1) end,
    { desc = 'Next buffer' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bp',
    function() require('bufferline').cycle(-1) end,
    { desc = 'Previous buffer' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bN',
    function() require('bufferline').move(1) end,
    { desc = 'Move buffer forward' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>bP',
    function() require('bufferline').move(-1) end,
    { desc = 'Move buffer backward' }
  )
end
