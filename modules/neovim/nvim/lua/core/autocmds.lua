-- lua/core/autocmds.lua

-- Treesitter setup
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		if pcall(vim.treesitter.start) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
	desc = "Start treesitter parsing and indent",
})

-- clear the gutter's background
local function clear_gutter_bg()
	local groups = {
		"LineNr",
		"LineNrAbove",
		"LineNrBelow",
		"CursorLineNr",
		"SignColumn",
		"FoldColumn",
	}
	for _, group in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group })
		hl.bg = "none"
		vim.api.nvim_set_hl(0, group, hl)
	end
end

clear_gutter_bg()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = clear_gutter_bg,
})
