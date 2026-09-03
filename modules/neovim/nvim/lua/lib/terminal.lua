-- [nfnl] fnl/lib/terminal.fnl
local function make_toggle(cmd)
  local state = {buf = nil, win = nil}
  local function _1_()
    if (state.win and vim.api.nvim_win_is_valid(state.win)) then
      vim.api.nvim_win_close(state.win, false)
      state.win = nil
      return nil
    else
      if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
        state.buf = vim.api.nvim_create_buf(false, true)
      else
      end
      do
        local width = math.floor((vim.o.columns * 0.85))
        local height = math.floor((vim.o.lines * 0.85))
        local row = math.floor(((vim.o.lines - height) / 2))
        local col = math.floor(((vim.o.columns - width) / 2))
        state.win = vim.api.nvim_open_win(state.buf, true, {relative = "editor", width = width, height = height, row = row, col = col, style = "minimal", border = "rounded"})
      end
      if (vim.api.nvim_get_option_value("buftype", {buf = state.buf}) ~= "terminal") then
        vim.fn.termopen(cmd)
      else
      end
      return vim.cmd.startinsert()
    end
  end
  return _1_
end
return {["make-toggle"] = make_toggle}
