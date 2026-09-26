(set vim.opt_local.spell true)
(set vim.opt_local.wrap true)
(set vim.opt_local.foldmethod :expr)
(set vim.opt_local.foldexpr "v:lua.vim.treesitter.foldexpr()")

(vim.keymap.del :n :gO {:buffer 0})

;; Set markdown-specific surrounding in 'mini.surround'
(set vim.b.minisurround_config
     {:custom_surroundings {:L {:input ["%[().-()%]%(.-%)"]
                                :output (fn []
                                          (let [ms (require :mini.surround)
                                                link (ms.user_input "Link: ")]
                                            {:left "["
                                             :right (.. "](" link ")")}))}}})
