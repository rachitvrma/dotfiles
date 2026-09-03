-- [nfnl] plugin/taskwarrior.fnl
local term = require("lib.terminal")
local toggle = term["make-toggle"]("taskwarrior-tui")
return vim.keymap.set("n", "<leader>tw", toggle, {desc = "Toggle taskwarrior-tui"})
