do
  require('snacks').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      -- The section is like this so that lazy.stats is not sourced
      -- removing this section might lead to error of not being able to find
      -- lazy.nvim package manager
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        -- no 'startup' section — that's the one that requires lazy.stats
        { section = 'recent_files', limit = 8, padding = 1 },
        { section = 'projects', limit = 5, padding = 1 },
      },
    },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    picker = {
      enabled = true,
      -- set vim.ui.select to Snacks.picker()
      -- NOTE: dropbar.nvim also provides a way to replace vim.ui.select, but don't do that
      ui_select = true,
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    scratch = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  })
  vim.keymap.set(
    'n',
    '<leader>e',
    function() Snacks.explorer() end,
    { desc = 'Toggle [E]xplorer' }
  )

  -- Jump to references
  vim.keymap.set(
    'n',
    ']]',
    function() Snacks.words.jump(1) end,
    { desc = 'Next reference' }
  )
  vim.keymap.set(
    'n',
    '[[',
    function() Snacks.words.jump(-1) end,
    { desc = 'Prev reference' }
  )
  -- Use Lazygit without lazygit.nvim
  vim.keymap.set(
    'n',
    '<leader>lg',
    function() Snacks.lazygit.open() end,
    { desc = '[L]azy [G]it' }
  )
  -- Use cliphist for a list of clips
  vim.keymap.set(
    'n',
    '<leader>p',
    function() Snacks.picker.cliphist() end,
    { desc = 'Open Cli[P]hist' }
  )

  -- Advanced LSP Progress. This is directly copied snippet from Snacks.nvim docs
  ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
  local progress = vim.defaulttable()
  vim.api.nvim_create_autocmd('LspProgress', {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
      if not client or type(value) ~= 'table' then return end
      local p = progress[client.id]

      for i = 1, #p + 1 do
        if i == #p + 1 or p[i].token == ev.data.params.token then
          p[i] = {
            token = ev.data.params.token,
            msg = ('[%3d%%] %s%s'):format(
              value.kind == 'end' and 100 or value.percentage or 100,
              value.title or '',
              value.message and (' **%s**'):format(value.message) or ''
            ),
            done = value.kind == 'end',
          }
          break
        end
      end

      local msg = {} ---@type string[]
      progress[client.id] = vim.tbl_filter(
        function(v) return table.insert(msg, v.msg) or not v.done end,
        p
      )

      local spinner =
        { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
      vim.notify(table.concat(msg, '\n'), 'info', {
        id = 'lsp_progress',
        title = client.name,
        opts = function(notif)
          notif.icon = #progress[client.id] == 0 and ' '
            or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })

  -- Keymap for scratch buffers
  vim.keymap.set(
    'n',
    '<leader>.',
    function() Snacks.scratch() end,
    { desc = 'Toggle Scratch Buffer' }
  )
  vim.keymap.set(
    'n',
    '<leader>S',
    function() Snacks.scratch.select() end,
    { desc = 'Select Scratch Buffer' }
  )
end
