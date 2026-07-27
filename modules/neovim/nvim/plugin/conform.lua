require("conform").setup({
	formatters = {
		dprint = {
			args = function(_, ctx)
				local ext = vim.fn.fnamemodify(ctx.filename, ":e")
				return { "fmt", "--stdin", ext }
			end,
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "nixfmt" },

		c = { "clang-format" },
		cpp = { "clang-format" },

		-- Dprint stuff
		markdown = { "dprint" },
		yaml = { "dprint" },
		json = { "dprint" },
		toml = { "dprint" },

		-- Fish scripts formatting
		formatters_by_ft = {
			fish = { "fish_indent" },
		},
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
