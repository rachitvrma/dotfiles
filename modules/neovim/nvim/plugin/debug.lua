-- debug.lua
--
-- Shows how to use the DAP plugin to debug C/C++ code via codelldb.
--
-- Plugins (nvim-dap, nvim-dap-ui, nvim-nio) are installed via Nix in
-- module.nix's `startPlugins`. The codelldb adapter binary comes from
-- the vscode-lldb extension package, its store path exposed via
-- `vim.g.codelldb_path` (set in initLua, since the path is store-hashed
-- and unavailable to plain Lua). Nothing here fetches or installs
-- anything at runtime.

vim.keymap.set(
  'n',
  '<F5>',
  function() require('dap').continue() end,
  { desc = 'Debug: Start/Continue' }
)
vim.keymap.set(
  'n',
  '<F1>',
  function() require('dap').step_into() end,
  { desc = 'Debug: Step Into' }
)
vim.keymap.set(
  'n',
  '<F2>',
  function() require('dap').step_over() end,
  { desc = 'Debug: Step Over' }
)
vim.keymap.set(
  'n',
  '<F3>',
  function() require('dap').step_out() end,
  { desc = 'Debug: Step Out' }
)
vim.keymap.set(
  'n',
  '<leader>b',
  function() require('dap').toggle_breakpoint() end,
  { desc = 'Debug: Toggle Breakpoint' }
)
vim.keymap.set(
  'n',
  '<leader>B',
  function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
  { desc = 'Debug: Set Breakpoint' }
)
vim.keymap.set(
  'n',
  '<F7>',
  function() require('dapui').toggle() end,
  { desc = 'Debug: See last session result.' }
)

local dap = require('dap')
local dapui = require('dapui')

---@diagnostic disable-next-line: missing-fields
dapui.setup({
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  ---@diagnostic disable-next-line: missing-fields
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
})

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- codelldb adapter (C/C++)
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.g.codelldb_path,
    args = { '--port', '${port}' },
  },
}

local cpp_config = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.cpp = cpp_config
dap.configurations.c = cpp_config
