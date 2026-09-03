;; fnl/lib/terminal.fnl
;; Generic floating-terminal toggle. `(make-toggle "cmd")` returns a fresh
;; toggle function with its own independent buf/win state, so each caller
;; (taskwarrior/jjui/lazygit) gets an isolated terminal instance.

(fn make-toggle [cmd]
  (local state {:buf nil :win nil})
  (fn []
    (if (and state.win (vim.api.nvim_win_is_valid state.win))
        (do
          (vim.api.nvim_win_close state.win false)
          (set state.win nil))
        (do
          (when (not (and state.buf (vim.api.nvim_buf_is_valid state.buf)))
            (set state.buf (vim.api.nvim_create_buf false true)))
          (let [width (math.floor (* vim.o.columns 0.85))
                height (math.floor (* vim.o.lines 0.85))
                row (math.floor (/ (- vim.o.lines height) 2))
                col (math.floor (/ (- vim.o.columns width) 2))]
            (set state.win
                 (vim.api.nvim_open_win state.buf true
                                        {:relative :editor
                                         : width
                                         : height
                                         : row
                                         : col
                                         :style :minimal
                                         :border :rounded})))
          (when (not= (vim.api.nvim_get_option_value :buftype {:buf state.buf})
                      :terminal)
            (vim.fn.termopen cmd))
          (vim.cmd.startinsert)))))

{: make-toggle}
