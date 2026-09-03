(local term (require :lib.terminal))
(local toggle (term.make-toggle :lazygit))

(vim.keymap.set :n :<leader>tg toggle {:desc "Toggle lazygit"})
