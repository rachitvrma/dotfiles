local opt = vim.opt

-- title
opt.title = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Ruler
opt.ruler = true
opt.textwidth = 80
opt.colorcolumn = '80,120'

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- opt.smartindent = true -- Doesn't work with treesitter indent

-- UI
opt.termguicolors = true
opt.signcolumn = 'yes' -- always show gutter (prevents layout shift)
opt.cursorline = true
opt.scrolloff = 8 -- keep 8 lines above/below cursor
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Misc
opt.undofile = true -- persistent undo
opt.swapfile = false
opt.updatetime = 250 -- faster diagnostics
opt.clipboard = 'unnamedplus'

-- Clear the ~ signs in the gutter for newlines
opt.fillchars = {
  eob = ' ',
}
opt.listchars = {
  tab = '→ ',
  trail = '·',
  nbsp = '␣',
}

-- Treesitter setup
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
  desc = 'Start treesitter parsing and indent',
})

local function clear_gutter_bg()
  local groups = {
    'LineNr',
    'LineNrAbove',
    'LineNrBelow',
    'CursorLineNr',
    'SignColumn',
    'FoldColumn',
  }
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    hl.bg = nil
    ---@cast hl any
    vim.api.nvim_set_hl(0, group, hl)
  end
end
clear_gutter_bg()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = clear_gutter_bg,
})
