-- [nfnl] init.fnl
Config = {}
local gr = vim.api.nvim_create_augroup("custom-config", {})
local function _1_(event, pattern, callback, desc)
  local opts = {group = gr, pattern = pattern, callback = callback, desc = desc}
  return vim.api.nvim_create_autocmd(event, opts)
end
Config.new_autocmd = _1_
local function _2_(plugin_name, kinds, callback, desc)
  local f
  local function _3_(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if ((name == plugin_name) and vim.tbl_contains(kinds, kind)) then
      if not ev.data.active then
        vim.cmd.packadd(plugin_name)
      else
      end
      return callback(ev.data)
    else
      return nil
    end
  end
  f = _3_
  return Config.new_autocmd("PackChanged", "*", f, desc)
end
Config.on_packchanged = _2_
local misc = require("mini.misc")
local function _6_(f)
  return misc.safely("now", f)
end
Config.now = _6_
local function _7_(f)
  return misc.safely("later", f)
end
Config.later = _7_
if (vim.fn.argc(-1) > 0) then
  Config.now_if_args = Config.now
else
  Config.now_if_args = Config.later
end
local function _9_(ev, f)
  return misc.safely(("event:" .. ev), f)
end
Config.on_event = _9_
local function _10_(ft, f)
  return misc.safely(("filetype:" .. ft), f)
end
Config.on_filetype = _10_
return nil
