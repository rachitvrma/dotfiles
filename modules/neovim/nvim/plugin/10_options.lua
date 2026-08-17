do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  local opt = vim.opt

  -- title
  opt.title = true

  -- Enable mouse mode, can be useful when resizing nvim splits!
  opt.mouse = 'a'

  -- Don't show the mode since it's already in the status line
  opt.showmode = false

  -- Line numbers
  opt.number = true
  opt.relativenumber = true

  -- Ruler
  opt.ruler = true
  opt.textwidth = 80
  opt.colorcolumn = '80,120'

  -- Indentation
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.expandtab = true
  -- opt.smartindent = true -- Doesn't work with treesitter indent

  -- UI
  opt.termguicolors = true
  opt.signcolumn = 'yes' -- always show gutter (prevents layout shift)
  opt.cursorline = true
  opt.scrolloff = 10 -- keep 10 lines above/below cursor
  opt.wrap = false

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  opt.confirm = true

  -- Search
  opt.ignorecase = true
  opt.smartcase = true
  opt.hlsearch = false
  opt.incsearch = true

  -- Splits
  opt.splitright = true
  opt.splitbelow = true

  -- Misc
  opt.undofile = true -- persistent undo
  opt.swapfile = false
  opt.updatetime = 250 -- faster diagnostics

  -- Decrease mapped sequence wait time
  opt.timeoutlen = 300

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  opt.breakindent = true

  -- Preview substitution live, as you type!
  opt.inccommand = 'split'

  -- Clear the ~ signs in the gutter for newlines
  opt.fillchars = {
    eob = ' ',
  }
  opt.list = true
  opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Treesitter setup
  vim.api.nvim_create_autocmd('FileType', {
    callback = function()
      if pcall(vim.treesitter.start) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
    desc = 'Start treesitter parsing and indent',
  })

  local function clear_gutter_bg()
    local groups = {
      'LineNr',
      'LineNrAbove',
      'LineNrBelow',
      'CursorLineNr',
      'SignColumn',
      'FoldColumn',
    }
    for _, group in ipairs(groups) do
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      hl.bg = nil
      ---@cast hl any
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
  clear_gutter_bg()

  vim.api.nvim_create_autocmd('ColorScheme', {
    callback = clear_gutter_bg,
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufname = vim.api.nvim_buf_get_name(args.buf)
      if bufname:match('maintainer%-list%.nix$') then
        vim.lsp.buf_detach_client(args.buf, args.data.client_id)
      end
    end,
  })
end
