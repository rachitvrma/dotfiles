-- [nfnl] plugin/40_plugins.fnl
local now_if_args = Config.now_if_args
local later = Config.later
local function _1_()
  local available = require("nvim-treesitter").get_available()
  local ts_start
  local function _2_(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if (lang and vim.tbl_contains(available, lang)) then
      vim.treesitter.start(ev.buf)
      if vim.treesitter.query.get(lang, "indents") then
        vim.bo[ev.buf]["indentexpr"] = "v:lua.require'nvim-treesitter'.indentexpr()"
        return nil
      else
        return nil
      end
    else
      return nil
    end
  end
  ts_start = _2_
  return Config.new_autocmd("FileType", nil, ts_start, "Start tree-sitter")
end
now_if_args(_1_)
local function _5_()
  local lua_ls_on_init
  local function _6_(client)
    client.server_capabilities.documentFormattingProvider = false
    local has_own_luarc_3f
    local and_7_ = client.workspace_folders
    if and_7_ then
      local path = client.workspace_folders[1].name
      and_7_ = ((path ~= vim.fn.stdpath("config")) and (vim.uv.fs_stat((path .. "/.luarc.json")) or vim.uv.fs_stat((path .. "/.luarc.jsonc"))))
    end
    has_own_luarc_3f = and_7_
    if not has_own_luarc_3f then
      local current_settings = client.config.settings
      client.config.settings.Lua = vim.tbl_deep_extend("force", current_settings.Lua, {runtime = {version = "LuaJIT", path = {"lua/?.lua", "lua/?/init.lua"}}, workspace = {library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false}})
      return nil
    else
      return nil
    end
  end
  lua_ls_on_init = _6_
  local servers = {stylua = {}, fennel_ls = {}, nixd = {cmd = {"nixd", "--semantic-tokens=true"}, settings = {nixd = {nixpkgs = {expr = "import <nixpkgs> { }"}, formatting = {command = {"nixfmt"}}, options = {nixos = {expr = "(builtins.getFlake \"/home/krish/etc/nixos\").nixosConfigurations.nixpavilion.options"}, home_manager = {expr = "(builtins.getFlake \"/home/krish/etc/nixos\").homeConfigurations.krish.options"}}}}}, lua_ls = {on_init = lua_ls_on_init, settings = {Lua = {format = {enable = false}}}}}
  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
  return nil
end
now_if_args(_5_)
local function _10_()
  return require("conform").setup({default_format_opts = {lsp_format = "fallback"}, format_on_save = {lsp_format = "fallback", timeout_ms = 500}, formatters = {stylua = {}, fnlfmt = {}}, formatters_by_ft = {lua = {"stylua"}, nix = {"nixfmt"}, fennel = {"fnlfmt"}, markdown = {"dprint"}}})
end
later(_10_)
local function _11_()
  return require("lazydev").setup({library = {{path = "mini.nvim", words = {"Mini%u%w+"}}}})
end
now_if_args(_11_)
local function _12_()
  return require("guess-indent").setup({})
end
return now_if_args(_12_)
