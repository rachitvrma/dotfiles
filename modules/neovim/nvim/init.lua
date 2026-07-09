vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.lsp")

-- Should always be at the end of the init.lua
require("lzn-auto-require").enable()
