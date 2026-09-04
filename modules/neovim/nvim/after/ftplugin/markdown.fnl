(set vim.opt_local.spell true)
(set vim.opt_local.wrap true)
(set vim.opt_local.foldmethod :expr)
(set vim.opt_local.foldexpr "v:lua.vim.treesitter.foldexpr()")

(vim.keymap.del :n :gO {:buffer 0})

(vim.keymap.set :n :<leader>x
                (fn []
                  (let [line (vim.api.nvim_get_current_line)]
                    (vim.api.nvim_set_current_line (if (line:match "%[ %]")
                                                       (line:gsub "%[ %]" "[x]")
                                                       (line:gsub "%[x%]" "[ ]")))))
                {:buffer 0 :desc "Toggle checkbox"})

;; Set markdown-specific surrounding in 'mini.surround'
(set vim.b.minisurround_config
     {:custom_surroundings {:L {:input ["%[().-()%]%(.-%)"]
                                :output (fn []
                                          (let [ms (require :mini.surround)
                                                link (ms.user_input "Link: ")]
                                            {:left "["
                                             :right (.. "](" link ")")}))}}})
