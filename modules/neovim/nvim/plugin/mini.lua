local gen_ai_spec = require("mini.extra").gen_ai_spec
require("mini.ai").setup({
	custom_textobjects = {
		B = gen_ai_spec.buffer(),
		D = gen_ai_spec.diagnostic(),
		I = gen_ai_spec.indent(),
		L = gen_ai_spec.line(),
		N = gen_ai_spec.number(),
	},
})
require("mini.ai").setup()

require("mini.align").setup()
require("mini.animate").setup()

require("mini.base16").setup({
	palette = {
		base00 = "#141617",
		base01 = "#1d2021",
		base02 = "#282828",
		base03 = "#5a524c",
		base04 = "#bdae93",
		base05 = "#ddc7a1",
		base06 = "#ebdbb2",
		base07 = "#fbf1c7",
		base08 = "#ea6962",
		base09 = "#e78a4e",
		base0A = "#d8a657", -- yellow
		base0B = "#a9b665", -- green
		base0C = "#89b482", -- aqua/cyan
		base0D = "#7daea3", -- blue (your secondary accent)
		base0E = "#d3869b", -- magenta (your primary accent)
		base0F = "#bd6f3e", -- orange/brown
	},
	use_cterm = true,
	plugins = { default = true },
})

require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.bufremove").setup()

-- Set up mini.clue for which key like thing
local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = { "n", "x" }, keys = "<Leader>" },

		-- `[` and `]` keys
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },

		-- Built-in completion
		{ mode = "i", keys = "<C-x>" },

		-- `g` key
		{ mode = { "n", "x" }, keys = "g" },

		-- Marks
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },

		-- Registers
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },

		-- Window commands
		{ mode = "n", keys = "<C-w>" },

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
require("mini.extra").setup()
require("mini.files").setup()
require("mini.fuzzy").setup()
require("mini.git").setup()

local hi_words = require("mini.extra").gen_highlighter.words
require("mini.hipatterns").setup({
	highlighters = {
		todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
		note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
		fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
		hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsFixme"),
	},
})

require("mini.icons").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.snippets").setup()
-- require("mini.starter").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.visits").setup()
