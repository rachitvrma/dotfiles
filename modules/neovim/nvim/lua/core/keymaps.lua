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

-- New file
nmap_leader("fe", function()
	vim.ui.input({ prompt = "New file: ", completion = "file" }, function(name)
		if name and name ~= "" then
			vim.cmd.edit(name)
		end
	end)
end, "New file")

-- Find file
nmap_leader("ff", function()
	MiniPick.builtin.files()
end, "Find file")

-- Recently opened files
nmap_leader("fh", function()
	MiniExtra.pickers.oldfiles()
end, "Recent files")

-- Frequency / MRU (mini.visits' default sort is frecency: frequency + recency combined)
nmap_leader("fr", function()
	MiniExtra.pickers.visit_paths()
end, "Frecent files")

-- Find word — live ripgrep search
nmap_leader("fg", function()
	MiniPick.builtin.grep_live()
end, "Find word (rg)")

-- Jump to bookmarks — Vim marks, via mini.extra
nmap_leader("fm", function()
	MiniExtra.pickers.marks()
end, "Jump to bookmark")

-- Open last session
nmap_leader("sl", function()
	local latest_name, latest_time = nil, -1
	for name, data in pairs(MiniSessions.detected) do
		if data.modify_time > latest_time then
			latest_name, latest_time = name, data.modify_time
		end
	end
	if latest_name then
		MiniSessions.read(latest_name)
	else
		vim.notify("No sessions found", vim.log.levels.WARN)
	end
end, "Open last session")

-- MiniFiles toggle at the current directory
vim.keymap.set("n", "<leader>e", function()
	local mini_files = require("mini.files")
	if not mini_files.close() then
		mini_files.open(vim.api.nvim_buf_get_name(0))
	end
end, { desc = "Toggle file explorer" })

-- Dropbar related keymaps
local dropbar_api = require("dropbar.api")

vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick breadcrumb symbol" })
vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to context start" })
vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
