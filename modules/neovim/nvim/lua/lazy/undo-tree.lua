-- [nfnl] lua/lazy/undo-tree.fnl
return {
  'undotree',
  keys = { { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle undo tree' } },
  cmd = { 'UndotreeToggle' },
}
