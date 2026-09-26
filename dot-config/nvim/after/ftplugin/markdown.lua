-- [nfnl] after/ftplugin/markdown.fnl
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.keymap.del("n", "gO", {buffer = 0})
local function _1_()
  local ms = require("mini.surround")
  local link = ms.user_input("Link: ")
  return {left = "[", right = ("](" .. link .. ")")}
end
vim.b.minisurround_config = {custom_surroundings = {L = {input = {"%[().-()%]%(.-%)"}, output = _1_}}}
return nil
