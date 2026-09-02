-- [nfnl] fnl/lazy/debug.fnl
local function _1_()
  return require("dap").toggle_breakpoint()
end
local function _2_()
  return nil
end
return {"nvim-dap", keys = {{"<leader>db", _1_, desc = "Toggle breakpoint"}}, after = _2_}
