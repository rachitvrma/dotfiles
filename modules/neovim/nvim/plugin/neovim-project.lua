require('neovim-project').setup({
  projects = {
    '~/Projects/*',
    '~/etc/nixos/*',
  },
  picker = {
    type = 'snacks',
  },
})
