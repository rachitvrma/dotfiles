-- NOTE: Using the 'startup' option in dashboard will result in error because it requires lazy.nvim libraries, which I am not gonna install.
do
  require('snacks').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    terminal = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          {
            icon = ' ',
            key = 'f',
            desc = 'Find File',
            action = ":lua Snacks.dashboard.pick('files')",
          },
          {
            icon = ' ',
            key = 'n',
            desc = 'New File',
            action = ':ene | startinsert',
          },
          {
            icon = ' ',
            key = 'p',
            desc = 'Projects',
            action = ":lua Snacks.dashboard.pick('projects')",
          },
          {
            icon = ' ',
            key = 'g',
            desc = 'Find Text',
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        {
          pane = 2,
          section = 'terminal',
          cmd = 'colorscript -e square',
          height = 5,
          padding = 1,
        },
        { section = 'keys', gap = 1, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = 'git status --short --branch --renames',
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
      },
    },
    explorer = { enabled = true },
    gitbrowse = { enabled = true },
    image = { enabled = true },
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

  Snacks.keymap.set(
    'n',
    '<leader>e',
    function() Snacks.explorer() end,
    { desc = 'Toggle [E]xplorer' }
  )

  -- Jump to references
  Snacks.keymap.set(
    'n',
    ']]',
    function() Snacks.words.jump(1) end,
    { desc = 'Next reference' }
  )
  Snacks.keymap.set(
    'n',
    '[[',
    function() Snacks.words.jump(-1) end,
    { desc = 'Prev reference' }
  )
  -- Use Lazygit without lazygit.nvim
  Snacks.keymap.set(
    'n',
    '<leader>lg',
    function() Snacks.lazygit.open() end,
    { desc = '[L]azy [G]it' }
  )
  -- Use cliphist for a list of clips
  Snacks.keymap.set(
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
  Snacks.keymap.set(
    'n',
    '<leader>.',
    function() Snacks.scratch() end,
    { desc = 'Toggle Scratch Buffer' }
  )
  Snacks.keymap.set(
    'n',
    '<leader>S',
    function() Snacks.scratch.select() end,
    { desc = 'Select Scratch Buffer' }
  )

  -- Quickly choose buffers
  Snacks.keymap.set(
    'n',
    '<leader><leader>',
    function() Snacks.picker.buffers() end,
    { desc = 'Buffer list' }
  )

  -- SEARCHes
  -- See all the keymaps
  Snacks.keymap.set(
    'n',
    '<leader>k',
    function() Snacks.picker.keymaps() end,
    { desc = '[K]eymaps' }
  )
  -- Search for files
  Snacks.keymap.set(
    'n',
    '<leader>sf',
    function() Snacks.picker.files() end,
    { desc = '[F]iles' }
  )
  -- Search for projects
  Snacks.keymap.set(
    'n',
    '<leader>sp',
    function() Snacks.picker.projects() end,
    { desc = '[P]rojects' }
  )

  vim.ui.input = Snacks.input()
  vim.ui.select = Snacks.picker.select()
end
