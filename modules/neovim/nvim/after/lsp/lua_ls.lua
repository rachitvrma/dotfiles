-- [nfnl] after/lsp/lua_ls.fnl
local function _1_(client, buf_id)
  client.server_capabilities.completionProvider.triggerCharacters =
    { '.', ':', '#', '(' }
  return nil
end
return {
  on_attach = _1_,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      workspace = { ignoreSubmodules = true, library = { vim.env.VIMRUNTIME } },
    },
  },
}
