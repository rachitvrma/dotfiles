;; ┌──────────────────────────┐
;; │ Built-in Neovim behavior │
;; └──────────────────────────┘
;;
;; This file defines Neovim's built-in behavior. The goal is to improve overall
;; usability in a way that works best with MINI.
;;
;; Here `(set vim.o.xxx value)` sets default value of option `xxx` to `value`.
;; See `:h 'xxx'` (replace `xxx` with actual option name).
;;
;; Option values can be customized on a per buffer or window basis.
;; See 'after/ftplugin/' for common example.
;;
;; Notes:
;; - Some options (like `:h 'exrc'`) need to be set before this file is sourced.
;;   Set them directly at the bottom of the 'init.lua' file.

;; General =====================================================================
(set vim.g.mapleader " ")

;; Use `<Space>` as <Leader> key

(set vim.o.mouse :a)

;; Enable mouse
(set vim.o.mousescroll "ver:25,hor:6")

;; Customize mouse scroll
(set vim.o.switchbuf :usetab)

;; Use already opened buffers when switching
(set vim.o.undofile true)

;; Enable persistent undo

(set vim.o.shada "'100,<50,s10,:1000,/100,@100,h")

;; Limit ShaDa file (for startup)

;; UI ==========================================================================
(set vim.o.background :dark)

;; Opt for dark background
(set vim.o.breakindent true)

;; Indent wrapped lines to match line start
(set vim.o.breakindentopt "list:-1")

;; Add padding for lists (if 'wrap' is set)
(set vim.o.colorcolumn :+1)

;; Draw column on the right of maximum width
(set vim.o.cursorline true)

;; Enable current line highlighting
(set vim.o.linebreak true)

;; Wrap lines at 'breakat' (if 'wrap' is set)
(set vim.o.list true)

;; Set cmdheight to 0
(set vim.o.cmdheight 0)

;; Show helpful text indicators
(set vim.o.number true)

;; Show line numbers
(set vim.o.relativenumber true)

;; Show relative line numbers
(set vim.o.pumborder :rounded)

;; Use border in popup menu
(set vim.o.pumheight 10)

;; Make popup menu smaller
(set vim.o.pummaxwidth 100)

;; Make popup menu not too wide
(set vim.o.ruler false)

;; Don't show cursor coordinates
(set vim.o.shortmess :CFOSWaco)

;; Disable some built-in completion messages
(set vim.o.showmode false)

;; Don't show mode in command line
(set vim.o.signcolumn :yes)

;; Always show signcolumn (less flicker)
(set vim.o.splitbelow true)

;; Horizontal splits will be below
(set vim.o.splitkeep :screen)

;; Reduce scroll during window split
(set vim.o.splitright true)

;; Vertical splits will be to the right
(set vim.o.winborder :rounded)

;; Use border in floating windows
(set vim.o.wrap false)

;; Don't visually wrap lines (toggle with \w)

(set vim.o.cursorlineopt "screenline,number")

;; Show cursor line per screen line

;; Special UI symbols. More is set via 'mini.basics' later.
(set vim.o.fillchars "eob: ,fold:╌")
(set vim.o.listchars "extends:…,nbsp:␣,precedes:…,tab:> ")

;; Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
(set vim.o.foldlevel 10)

;; Fold nothing by default; set to 0 or 1 to fold
(set vim.o.foldmethod :indent)

;; Fold based on indent level
(set vim.o.foldnestmax 10)

;; Limit number of fold levels
(set vim.o.foldtext "")

;; Show text under fold with its highlighting

;; Editing =====================================================================
(set vim.o.autoindent true)

;; Use auto indent
(set vim.o.expandtab true)

;; Convert tabs to spaces
(set vim.o.formatoptions :rqnl1j)

;; Improve comment editing
(set vim.o.ignorecase true)

;; Ignore case during search
(set vim.o.incsearch true)

;; Show search matches while typing
(set vim.o.infercase true)

;; Infer case in built-in completion
(set vim.o.shiftwidth 2)

;; Use this number of spaces for indentation
(set vim.o.smartcase true)

;; Respect case if search pattern has upper case
(set vim.o.smartindent true)

;; Make indenting smart
(set vim.o.spelloptions :camel)

;; Treat camelCase word parts as separate words
(set vim.o.tabstop 2)

;; Show tab as this number of spaces
(set vim.o.virtualedit :block)

;; Allow going past end of line in blockwise mode

(set vim.o.iskeyword "@,48-57,_,192-255,-")

;; Treat dash as `word` textobject part

;; Pattern for a start of numbered list (used in `gw`). This reads as
;; "Start of list item is: at least one special character (digit, -, +, *)
;; possibly followed by punctuation (. or `)`) followed by at least one space".
(set vim.o.formatlistpat "^\\s*[0-9\\-\\+\\*]\\+[\\.\\)]*\\s\\+")

;; Built-in completion
(set vim.o.complete ".,w,b,kspell")

;; Use less sources
(set vim.o.completeopt "menuone,noselect,fuzzy,nosort")

;; Use custom behavior
(set vim.o.completetimeout 100)

;; Limit sources delay

;; Custom options set by me
(vim.schedule (fn [] (set vim.o.clipboard :unnamedplus)))

;; MiniMax doesn't touch clipboard at all
(set vim.o.updatetime 250)

;; default 4000ms is sluggish for lightbulb/gitsigns/diagnostics
(set vim.o.timeoutlen 300)

;; affects mini.clue's popup delay too — your call on feel
(set vim.o.inccommand :split)

;; live substitution preview, MiniMax leaves this unset
(set vim.o.scrolloff 10)
(set vim.o.confirm true)
(set vim.o.jumpoptions :view)
(set vim.g.markdown_recommended_style 0)

;; otherwise markdown ftplugin overrides your shiftwidth=2 to 4
(set vim.o.softtabstop 2)
(set vim.o.shiftround true)
(set vim.o.smoothscroll true)
(set vim.o.sidescrolloff 8)

;; pairs well with MiniMax's wrap=false
(set vim.o.undolevels 10000)
(set vim.o.winminwidth 5)
(set vim.o.pumblend 10)
(set vim.o.laststatus 3)

;; global statusline; MiniMax leaves Neovim's default (2, per-window)

;; Autocommands ================================================================

;; Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
;; Do on `FileType` to always override these changes from filetype plugins.
(local f (fn [] (vim.cmd "setlocal formatoptions-=c formatoptions-=o")))
(Config.new_autocmd :FileType nil f "Proper 'formatoptions'")

;; There are other autocommands created by 'mini.basics'. See 'plugin/30_mini.lua'.

;; Diagnostics ==================================================================

;; Neovim has built-in support for showing diagnostic messages. This configures
;; a more conservative display while still being useful.
;; See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
(local diagnostic-opts {;; Show signs on top of any other sign, but only for warnings and errors
                        :signs {:priority 9999
                                :severity {:min :WARN :max :ERROR}}
                        ;; Show all diagnostics as underline (for their messages type `<Leader>ld`)
                        :underline {:severity {:min :HINT :max :ERROR}}
                        ;; Show more details immediately for errors on the current line
                        :virtual_lines false
                        :virtual_text {:current_line true
                                       :severity {:min :ERROR :max :ERROR}}
                        ;; Don't update diagnostics when typing
                        :update_in_insert false})

;; Use `later()` to avoid sourcing `vim.diagnostic` on startup
(Config.later (fn [] (vim.diagnostic.config diagnostic-opts)))

((. (require :vim._core.ui2) :enable))
