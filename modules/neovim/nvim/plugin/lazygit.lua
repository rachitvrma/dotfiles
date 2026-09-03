-- [nfnl] plugin/lazygit.fnl
local term = require("lib.terminal")
local toggle = term["make-toggle"]("lazygit")
return vim.keymap.set("n", "<leader>tg", toggle, {desc = "Toggle lazygit"})
