local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- opt.smartindent = true -- Doesn't work with treesitter indent

-- UI
opt.termguicolors = true
opt.signcolumn = "yes" -- always show gutter (prevents layout shift)
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
opt.clipboard = "unnamedplus"

-- Clear the ~ signs in the gutter for newlines
opt.fillchars = {
	eob = " ",
}
