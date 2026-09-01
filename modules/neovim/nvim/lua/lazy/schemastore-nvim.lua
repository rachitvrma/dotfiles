-- [nfnl] lua/lazy/schemastore-nvim.fnl
local function _1_()
  local schemastore = require("schemastore")
  vim.lsp.config("jsonls", {settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}})
  vim.lsp.enable("jsonls")
  vim.lsp.config("yamlls", {settings = {yaml = {schemas = schemastore.yaml.schemas()}}})
  return vim.lsp.enable("yamlls")
end
return {"SchemaStore.nvim", ft = {"json", "jsonc", "yaml"}, after = _1_}
