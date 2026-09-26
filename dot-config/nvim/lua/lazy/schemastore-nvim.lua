-- [nfnl] fnl/lazy/schemastore-nvim.fnl
local function _1_()
  local schemastore = require("schemastore")
  _G.vim.lsp.config("jsonls", {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}})
  _G.vim.lsp.enable("jsonls")
  _G.vim.lsp.config("yamlls", {settings = {yaml = {schemas = schemastore.yaml.schemas()}}})
  return _G.vim.lsp.enable("yamlls")
end
return {"SchemaStore.nvim", ft = {"json", "jsonc", "yaml"}, after = _1_}
