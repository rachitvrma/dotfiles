-- [nfnl] lua/lazy/lightbulb.fnl
local function _1_()
  local nvim_lightbulb = require("nvim-lightbulb")
  return nvim_lightbulb.setup({autocmd = {enabled = true}})
end
return {"nvim-lightbulb", event = "LspAttach", after = _1_}
