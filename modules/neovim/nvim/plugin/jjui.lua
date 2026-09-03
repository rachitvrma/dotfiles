-- [nfnl] plugin/jjui.fnl
local term = require("lib.terminal")
local toggle = term["make-toggle"]("jjui")
return vim.keymap.set("n", "<leader>tj", toggle, {desc = "Toggle jjui"})
