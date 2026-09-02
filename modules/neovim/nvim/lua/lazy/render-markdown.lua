-- [nfnl] fnl/lazy/render-markdown.fnl
local function _1_()
  return require("render-markdown").setup()
end
return {"render-markdown.nvim", ft = {"markdown"}, after = _1_}
