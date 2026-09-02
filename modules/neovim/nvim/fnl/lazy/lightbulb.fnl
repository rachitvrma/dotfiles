; return {
;   'nvim-lightbulb',
;   event = 'LspAttach',
;   after = function()
;     require('nvim-lightbulb').setup({
;       autocmd = { enabled = true },
;     })
;   end,
; }
;
;
{1 :nvim-lightbulb
 :event :LspAttach
 :after (fn []
          (local nvim-lightbulb (require :nvim-lightbulb))
          (nvim-lightbulb.setup {:autocmd {:enabled true}}))}
