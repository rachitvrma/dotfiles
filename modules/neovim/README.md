# Learning Resources: Neovim

## Neovim / Lua / Vim Regex / Editing Fluency

### Lua itself

- **[Learn Lua in Y Minutes](https://learnxinyminutes.com/lua/)** — fastest
  syntax-level primer if you already know programming; ~15 minutes.
- **[Programming in Lua (official book, 1st edition free online)](https://www.lua.org/pil/contents.html)**
  — the real depth resource. Covers closures, metatables, coroutines — all the
  stuff Neovim's Lua API leans on heavily.
- **[Lua 5.1 Reference Manual](https://www.lua.org/manual/5.1/)** — Neovim
  embeds LuaJIT (5.1-compatible), so this is the actual spec you're targeting,
  not 5.4.

  #### Do and Learn
  - Best overall: Lua on [Excersism](https://exercism.org/tracks/lua).
  - Best for Algorithm Practice: [Codewars](https://www.codewars.com/).
  - Game and Lua at the same time: [CodinGame](https://www.codingame.com/start/).
  - We got [Rosetta Code](https://rosettacode.org/wiki/Rosetta_Code).

### Neovim's Lua API specifically

- **`:help lua-guide`** — genuinely underrated; open it in Neovim itself
  (`nvim-lua-guide` is now upstreamed into core help docs). Covers
  `vim.api`, `vim.fn`, `vim.opt` vs `vim.o` vs `vim.g`, autocommands, etc.
- **[nanotee/nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide)** — the
  original standalone version of the above, still useful for the prose framing.
- **`:help lsp`** and **`:help vim.lsp.config`** — given you're hand-rolling
  `lua_ls`/`nixd`/etc. via the new `vim.lsp.config`/`vim.lsp.enable` API
  (not `nvim-lspconfig` wrappers), the built-in help is more current than most
  blog posts right now since this API is fairly recent.
- **[TJ DeVries' YouTube channel](https://www.youtube.com/@teej_dv)** — core
  Neovim maintainer; his config-building and plugin-authoring streams are the
  closest thing to "how the maintainers actually think about the Lua API."
- **[ThePrimeagen's Neovim series](https://www.youtube.com/@ThePrimeagen)** —
  more opinionated/entertainment-first, but the older "0 to LSP" series is a
  decent second angle on LSP config specifically.

### Vim motions / regex / "editing as a language"

- **[vimregex.com](https://vimregex.com/)** — the best single reference for
  Vim's regex dialect (magic/nomagic/very-magic, differences from PCRE).
- **[Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)**
  — despite the name, half of it is really "learn Vim's editing model the hard
  way" — the early chapters on motions/operators/text-objects are the highest
  ROI even if you never write another line of Vimscript (you're in Lua-land).
- **[Vim Adventures](https://vim-adventures.com/)** — a genuine game for drilling
  motions into muscle memory if you want something less textual.
- **[Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)** — uneven
  quality but deep; good for "is there a motion for X" lookups.
- **`:help motion.txt`**, **`:help pattern.txt`**, **`:help text-objects`** —
  as always, the built-in help is the ground truth and often more precise than
  any blog summary of the same material.

### Config architecture / "how do people actually structure this"

- **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** — not to
  use wholesale, but a good single-file reference for idiomatic modern
  (`vim.lsp.enable`-era) config structure.
- **[folke/lazydev.nvim](https://github.com/folke/lazydev.nvim)** and
  **[echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)** repo
  READMEs themselves — since your whole stack is mini.* modules, the module
  READMEs (not third-party tutorials) are consistently the best documentation;
  each module's README doubles as a design-rationale doc, e.g. `mini.pick`'s
  README explains the picker/source/action model better than any blog post will.

### Where mini.nvim specifically is documented

- **[mini.nvim online docs](https://github.com/echasnovski/mini.nvim/tree/main/doc)**
  — raw vimdoc, but complete and current; given how fast mini.nvim ships, this
  is more reliable than any tutorial for exact API surface (e.g. the
  `MiniSessions.detected` field names we were just cross-checking).
