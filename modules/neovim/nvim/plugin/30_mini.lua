local gen_ai_spec = require('mini.extra').gen_ai_spec
require('mini.ai').setup({
  custom_textobjects = {
    B = gen_ai_spec.buffer(),
    D = gen_ai_spec.diagnostic(),
    I = gen_ai_spec.indent(),
    L = gen_ai_spec.line(),
    N = gen_ai_spec.number(),
  },
})

require('mini.align').setup()
require('mini.animate').setup()

require('mini.basics').setup({
  options = {
    basic = true,
    extra_ui = true,
  },
  mappings = {
    basic = true,
    windows = true,
    move_with_alt = true,
  },
  autocommands = {
    basic = true,
    relnum_in_visual_mode = true,
  },
})
require('mini.bracketed').setup()
require('mini.bufremove').setup()

-- Set up mini.clue for which key like thing
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },

    -- Dropbar related
    { mode = 'n', keys = '<Leader>;', desc = 'Breadcrumb pick' },

    -- For surround
    { mode = { 'n', 'x' }, keys = 's' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),

    { mode = 'n', keys = '<Leader>b', desc = '+Buffers' },
    { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  },
})

require('mini.cmdline').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.diff').setup()
require('mini.doc').setup()
require('mini.extra').setup()
require('mini.files').setup()
require('mini.fuzzy').setup()
require('mini.git').setup()

local hi_words = require('mini.extra').gen_highlighter.words
local hipatterns = require('mini.hipatterns')

-- disable certain keywords in markdown files
local note_group = function(buf_id)
  if vim.bo[buf_id].filetype == 'markdown' then return nil end
  return 'MiniHipatternsNote'
end

require('mini.hipatterns').setup({
  highlighters = {
    todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
    note = hi_words({ 'NOTE' }, note_group),
    fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
    hack = hi_words({ 'HACK' }, 'MiniHipatternsFixme'),

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require('mini.icons').setup()
MiniIcons.tweak_lsp_kind('prepend')

require('mini.indentscope').setup()

require('mini.input').setup()
require('mini.operators').setup({
  mappings = {
    replace = 'gl',
  },
})

-- Swap adjacent arguments. Relies on the `a` argument textobject from
-- 'mini.ai'; not 100% reliable but mostly works. Overrides the built-in
-- `(`/`)` sentence-navigation keys.
-- Usage: cursor on `aa` in `(aa, bb)`, press `)` to swap right, `(` to swap left.
vim.keymap.set('n', '(', 'gxiagxila', { remap = true, desc = 'Swap arg left' })
vim.keymap.set('n', ')', 'gxiagxina', { remap = true, desc = 'Swap arg right' })

require('mini.jump').setup() -- smarter f/F/t/T with repeat + highlight, no config needed
require('mini.jump2d').setup({
  labels = 'arstgmneio' .. 'bcdfhjklpquvwxyz',
})

-- Mini.keymap setup
require('mini.keymap').setup()
local map_multistep = require('mini.keymap').map_multistep

map_multistep(
  'i',
  '<Tab>',
  { 'minisnippets_next', 'minisnippets_expand', 'pmenu_next' }
)
map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'pmenu_prev' })
map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
map_multistep('i', '<BS>', { 'minipairs_bs' })

local map = require('mini.map')
map.setup({
  symbols = { encode = map.gen_encode_symbols.dot('4x2') },
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diagnostic(),
    map.gen_integration.diff(), -- replaces gen_integration.gitsigns()
  },
})

-- Force map refresh (and open enough folds) after a search jump
for _, key in ipairs({ 'n', 'N', '*', '#' }) do
  local rhs = key
    .. 'zv'
    .. '<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>'
  vim.keymap.set('n', key, rhs)
end

require('mini.misc').setup()
require('mini.misc').setup_restore_cursor() -- reopen a file at last cursor pos

require('mini.move').setup()

require('mini.notify').setup()
require('mini.pairs').setup()

-- replaces: require("mini.pick").setup()
require('mini.pick').setup({
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})

require('mini.sessions').setup()
require('mini.snippets').setup()
require('mini.splitjoin').setup()

require('mini.starter').setup({
  evaluate_single = true,
  items = {
    -- project.nvim integration
    { name = 'Projects', action = 'Project', section = 'Projects' }, -- Runs `:Project`
    { name = 'Recent Projects', action = 'Project recents', section = 'Projects' }, -- `:Project recents`
  },
})

-- replaces: require("mini.statusline").setup()
local statusline = require('mini.statusline')
statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git = statusline.section_git({ trunc_width = 75 })
      local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
      local filename = statusline.section_filename({ trunc_width = 140 })
      local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
      local location = statusline.section_location({ trunc_width = 75 })
      local search = statusline.section_searchcount({ trunc_width = 75 })

      return statusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
        '%<', -- truncation point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- right-align
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end,
  },
})

require('mini.surround').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()
require('mini.visits').setup()
