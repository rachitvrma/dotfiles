-- [nfnl] fnl/lazy/image.fnl
local function _1_()
  return require("image").setup({integrations = {markdown = {only_render_image_at_cursor = true}}})
end
return {"image.nvim", ft = "markdown", after = _1_}
