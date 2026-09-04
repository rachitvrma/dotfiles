-- [nfnl] after/ftplugin/typst.fnl
local function _1_()
  local client = vim.lsp.get_clients({name = "tinymist", bufnr = 0})[1]
  return client:exec_cmd({command = "tinymist.startDefaultPreview"}, {bufnr = 0})
end
return vim.keymap.set("n", "<leader>tp", _1_, {buffer = true, desc = "Typst preview"})
