-- [nfnl] after/ftplugin/markdown.fnl
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.keymap.del("n", "gO", {buffer = 0})
local function _1_()
  local line = vim.api.nvim_get_current_line()
  local function _2_()
    if line:match("%[ %]") then
      return line:gsub("%[ %]", "[x]")
    else
      return line:gsub("%[x%]", "[ ]")
    end
  end
  return vim.api.nvim_set_current_line(_2_())
end
vim.keymap.set("n", "<leader>x", _1_, {buffer = 0, desc = "Toggle checkbox"})
local function _3_()
  local ms = require("mini.surround")
  local link = ms.user_input("Link: ")
  return {left = "[", right = ("](" .. link .. ")")}
end
vim.b.minisurround_config = {custom_surroundings = {L = {input = {"%[().-()%]%(.-%)"}, output = _3_}}}
return nil
