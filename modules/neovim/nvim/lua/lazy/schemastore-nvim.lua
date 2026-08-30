return {
  'SchemaStore.nvim', -- verify actual case/spelling via globpath first, same lesson as render-markdown
  ft = { 'json', 'jsonc', 'yaml' },
  after = function()
    vim.lsp.config('jsonls', {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })
    vim.lsp.enable('jsonls')

    vim.lsp.config('yamlls', {
      settings = { yaml = { schemas = require('schemastore').yaml.schemas() } },
    })
    vim.lsp.enable('yamlls')
  end,
}
