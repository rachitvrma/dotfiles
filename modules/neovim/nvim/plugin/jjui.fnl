(local term (require :lib.terminal))
(local toggle (term.make-toggle :jjui))

(vim.keymap.set :n :<leader>tj toggle {:desc "Toggle jjui"})
