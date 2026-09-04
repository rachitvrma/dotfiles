(vim.keymap.set :n :<leader>tp
                (fn []
                  (let [client (. (vim.lsp.get_clients {:name :tinymist
                                                        :bufnr 0})
                                  1)]
                    (: client :exec_cmd
                       {:command :tinymist.startDefaultPreview} {:bufnr 0})))
                {:buffer true :desc "Typst preview"})
