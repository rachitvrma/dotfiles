; return {
;   'render-markdown.nvim',
;   ft = 'markdown',
;   after = function() require('render-markdown').setup() end,
; }

; {1 :render-markdown
;  :ft [:markdown]
;  :config (fn []
;            (local render-markdown (require :render-markdown))
;            (render-markdown.setup))}

{1 :render-markdown.nvim
 :ft [:markdown]
 :after (fn []
          ((. (require :render-markdown) :setup)))}
