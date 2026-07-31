return {
	{
		"zk-nvim",
		ft = "markdown",
		after = function()
			require("zk").setup({
				picker = "minipick", -- matches your mini.pick ecosystem

				lsp = {
					config = {
						name = "zk",
						cmd = { "zk", "lsp" },
						filetypes = { "markdown" },
					},
					-- markdown_oxide stays the sole LSP; zk-nvim's commands/
					-- pickers below work over the CLI, not this LSP client.
					auto_attach = {
						enabled = false,
					},
				},
			})
		end,
	},
}
