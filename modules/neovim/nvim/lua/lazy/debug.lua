return {
  'nvim-dap',
  keys = {
    {
      '<leader>db',
      function() require('dap').toggle_breakpoint() end,
      desc = 'Toggle breakpoint',
    },
  },
  after = function()
    -- any one-time nvim-dap config (adapters, signs, etc.) goes here,
    -- runs once when the plugin first loads
  end,
}
