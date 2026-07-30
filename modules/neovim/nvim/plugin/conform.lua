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

		formatters_by_ft = {},
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
