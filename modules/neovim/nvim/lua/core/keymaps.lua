-- Leader keybindings utilising the mini keybindings
local nmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
	vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc })
end

nmap_leader("bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete")
nmap_leader("bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", "Wipeout")

nmap_leader("lf", "<Cmd>lua vim.lsp.buf.format()<CR>", "Format")
xmap_leader("lf", "<Cmd>lua vim.lsp.buf.format()<CR>", "Format")
nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
nmap_leader("lR", "<Cmd>lua vim.lsp.buf.references()<CR>", "References")

-- MiniFiles toggle at the current directory
vim.keymap.set("n", "<leader>e", function()
	local mini_files = require("mini.files")
	if not mini_files.close() then
		mini_files.open(vim.api.nvim_buf_get_name(0))
	end
end, { desc = "Toggle file explorer" })
