-- ftplugin/markdown.lua
-- Buffer-local overrides for markdown. Runs automatically whenever a buffer's
-- filetype becomes "markdown" — nothing in init.lua needs to require this.

local opt = vim.opt_local

-- Soft-wrap prose instead of hard-wrapping at a column. Markdown treats a run
-- of non-blank lines as one paragraph regardless of where you pressed <CR>,
-- so baking real newlines in at column 80 changes what the text *means* to
-- a renderer, not just how it looks in your editor. Soft-wrap keeps one
-- logical line per paragraph and only wraps the display.
opt.wrap = true
opt.linebreak = true -- wrap at word boundaries, not mid-word
opt.breakindent = true -- wrapped lines inherit the paragraph's indent
opt.showbreak = "↳ " -- visual cue that a line is wrapped, not new

-- If you'd rather hard-wrap (e.g. prose you diff/review as plain text),
-- swap the block above for:
-- opt.textwidth = 80
-- opt.colorcolumn = "+1"

-- Let `gq` reflow paragraphs without mangling lists: recognize bullets,
-- numbered items, and reference-link definitions so continuation lines get
-- correct hanging indent instead of being merged into one paragraph.
opt.formatoptions:append("n")
opt.formatoptions:remove("t") -- redundant once wrap+linebreak handle display wrapping
opt.formatlistpat = [[^\s*[-*+]\s\+\|^\s*\d\+[.)]\s\+\|^\s*\[.\{-}\]:\s*]]

-- Fold by heading instead of by braces/indent — much more useful for
-- navigating a long doc. Starts fully open; za/zc to fold on demand.
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- Conceal markdown syntax (e.g. hide the `**` around **bold**) when
-- render-markdown.nvim is active. Level 2 hides delimiters; "nc" keeps them
-- hidden in normal/command mode but reveals them on the line you're
-- currently editing, so you can still see and edit raw markup mid-line
-- instead of fighting fully-invisible characters.
opt.conceallevel = 2
opt.concealcursor = "nc"

-- gcc (mini.comment) doesn't know what a "comment" is in markdown by
-- default — this gives it one.
vim.bo.commentstring = "<!--%s-->"
