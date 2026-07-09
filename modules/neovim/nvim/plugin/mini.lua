require("mini.ai").setup()
require("mini.align").setup()
require("mini.animate").setup()
require("mini.bracketed").setup()
require("mini.bufremove").setup()

-- Set up mini.clue for which key like thing
local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
      -- Leader triggers
      { mode = { "n", "x" }, keys = "<Leader>" },

      -- `[` and `]` keys
      { mode = "n",          keys = "[" },
      { mode = "n",          keys = "]" },

      -- Built-in completion
      { mode = "i",          keys = "<C-x>" },

      -- `g` key
      { mode = { "n", "x" }, keys = "g" },

      -- Marks
      { mode = { "n", "x" }, keys = "'" },
      { mode = { "n", "x" }, keys = "`" },

      -- Registers
      { mode = { "n", "x" }, keys = '"' },
      { mode = { "i", "c" }, keys = "<C-r>" },

      -- Window commands
      { mode = "n",          keys = "<C-w>" },

      -- `z` key
      { mode = { "n", "x" }, keys = "z" },
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

      { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
      { mode = "n", keys = "<Leader>l", desc = "+LSP" },
    },
})

require("mini.cmdline").setup()
require("mini.comment").setup()
require("mini.completion").setup()
require("mini.cursorword").setup()
require("mini.diff").setup()
require("mini.doc").setup()
require("mini.files").setup()
require("mini.fuzzy").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.snippets").setup()
require("mini.starter").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.visits").setup()
