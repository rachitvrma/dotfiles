;; ┌─────────────────────────┐
;; │ Plugins outside of MINI │
;; └─────────────────────────┘
;;
;; This file contains installation and configuration of plugins outside of MINI.
;; They significantly improve user experience in a way not yet possible with MINI.
;; These are mostly plugins that provide programming language specific behavior.
;;
;; Use this file to install and configure other such plugins.

;; Make concise helpers for installing/adding plugins in two stages
(local now_if_args Config.now_if_args)
(local later Config.later)

;; Tree-sitter =================================================================
;;
;; Tree-sitter is a tool for fast incremental parsing. It converts text into
;; a hierarchical structure (called tree) that can be used to implement advanced
;; and/or more precise actions: syntax highlighting, textobjects, indent, etc.
;;
;; Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
;; requires two extra pieces that don't come with Neovim directly:
;; - Language parsers: programs that convert text into trees. Some are built-in
;;   (like for Lua), 'nvim-treesitter' provides many others.
;;   NOTE: It requires third party software to build and install parsers.
;;   See the link for more info in "Requirements" section of the MiniMax README.
;; - Query files: definitions of how to extract information from trees in
;;   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
;;   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
;;   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
;;
;; Add these plugins now if file (and not 'mini.starter') is shown after startup.
;;
;; Troubleshooting:
;; - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
;; - In case of errors related to queries for Neovim bundled parsers (like `lua`,
;;   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
;;   with `:TSInstall <language>`. Be sure to have necessary system dependencies
;;   (see MiniMax README section for software requirements).
(now_if_args
  (fn []
    (local available ((. (require :nvim-treesitter) :get_available)))
    (local ts_start
           (fn [ev]
             (local lang (vim.treesitter.language.get_lang ev.match))
             (when (and lang (vim.tbl_contains available lang))
               (vim.treesitter.start ev.buf)
               (when (vim.treesitter.query.get lang :indents)
                 (set (. vim.bo ev.buf :indentexpr)
                      "v:lua.require'nvim-treesitter'.indentexpr()")))))
    (Config.new_autocmd :FileType nil ts_start "Start tree-sitter")))

;; Language servers =============================================================
;;
;; Language Server Protocol (LSP) is a set of conventions that power creation of
;; language specific tools. It requires two parts:
;; - Server - program that performs language specific computations.
;; - Client - program that asks server for computations and shows results.
;;
;; Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
;; be installed separately based on your OS, CLI tools, and preferences.
;; See note about 'mason.nvim' at the bottom of the file.
;;
;; Neovim's team collects commonly used configurations for most language servers
;; inside 'neovim/nvim-lspconfig' plugin.
;;
;; Add it now if file (and not 'mini.starter') is shown after startup.
;;
;; Troubleshooting:
;; - Run `:checkhealth vim.lsp` to see potential issues.
(now_if_args
  (fn []
    ;; Enable the following language servers
    ;;  Feel free to add/remove any LSPs that you want here. They will
    ;;  automatically be installed.
    ;;  See `:help lsp-config` for information about keys and how to configure
    ;;  ---@type table<string, vim.lsp.Config>
    (local lua-ls-on-init
           (fn [client]
             ;; Disable formatting (formatting is done by stylua)
             (set client.server_capabilities.documentFormattingProvider false)

             ;; Has-own-.luarc-file? if so, skip the rest and let it govern settings
             (local has-own-luarc?
                    (and client.workspace_folders
                         (let [path (. client.workspace_folders 1 :name)]
                           (and (not= path (vim.fn.stdpath :config))
                                (or (vim.uv.fs_stat (.. path "/.luarc.json"))
                                    (vim.uv.fs_stat (.. path "/.luarc.jsonc")))))))

             (when (not has-own-luarc?)
               ;; NOTE: `current-settings` mirrors `client.config.settings` for
               ;; readability, matching the original Lua source's local alias.
               (local current-settings client.config.settings) ;[[@as lspconfig.settings.lua_ls]]
               (set client.config.settings.Lua
                    (vim.tbl_deep_extend :force current-settings.Lua
                                          {:runtime {:version :LuaJIT
                                                     :path [:lua/?.lua :lua/?/init.lua]}
                                           :workspace {:checkThirdParty false
                                                       ;; NOTE: this is a lot slower and will cause
                                                       ;; issues when working on your own configuration.
                                                       ;; See https://github.com/neovim/nvim-lspconfig/issues/3189
                                                       :library (vim.api.nvim_get_runtime_file "" true)}})))))

    (local servers
           {;; clangd = {},
            ;; gopls = {},
            ;; pyright = {},
            ;; rust_analyzer = {},
            ;;
            ;; Some languages (like typescript) have entire language plugins
            ;; that can be useful:
            ;;    https://github.com/pmizio/typescript-tools.nvim
            ;;
            ;; But for many setups, the LSP (`ts_ls`) will work just fine
            ;; ts_ls = {},

            :stylua {} ;; Used to format Lua code
            :fennel_ls {}

            :nixd {:cmd [:nixd "--semantic-tokens=true"]
                   :settings {:nixd {:nixpkgs {:expr "import <nixpkgs> { }"}
                                      :formatting {:command [:nixfmt]}
                                      :options {:nixos {:expr "(builtins.getFlake \"/home/krish/etc/nixos\").nixosConfigurations.nixpavilion.options"}
                                                :home_manager {:expr "(builtins.getFlake \"/home/krish/etc/nixos\").homeConfigurations.krish.options"}}}}}
            ;; Special Lua Config, as recommended by neovim help docs
            :lua_ls {:on_init lua-ls-on-init
                     ;; ---@type lspconfig.settings.lua_ls
                     :settings {:Lua {:format {:enable false}}}}}) ;; Disable formatting (formatting is done by stylua)

    ;; Automatically install LSPs and related tools to stdpath for Neovim
    (each [name server (pairs servers)]
      (vim.lsp.config name server)
      (vim.lsp.enable name))))

;; Formatting ====================================================================
;;
;; Programs dedicated to text formatting (a.k.a. formatters) are very useful.
;; Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
;; They can be used to configure external programs, but it might become tedious.
;;
;; The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
;; formatting setup.
(later
  (fn []
    ;; (add {1 :https://github.com/stevearc/conform.nvim})

    ;; See also:
    ;; - `:h Conform`
    ;; - `:h conform-options`
    ;; - `:h conform-formatters`
    ((. (require :conform) :setup)
     {:default_format_opts {;; Allow formatting from LSP server if no dedicated formatter is available
                             :lsp_format :fallback}

      ;; If this is set, Conform will run the formatter on save.
      ;; It will pass the table to conform.format().
      ;; This can also be a function that returns the table.
      :format_on_save {;; I recommend these options. See :help conform.format for details.
                        :lsp_format :fallback
                        :timeout_ms 500}
      ;; Map of filetype to formatters
      ;; Make sure that necessary CLI tool is available
      :formatters {:stylua {} ;; NOTE: Don't pass --search-parent-directories here: the
                              ;; Nix-wrapped `stylua` binary from programs.stylua already
                              ;; injects it via wrapProgram, so Conform's own default
                              ;; (which also adds this flag) would collide with it and
                              ;; stylua errors out.
                   :fnlfmt {}}
      :formatters_by_ft {:lua [:stylua]
                          :nix [:nixfmt]
                          :fennel [:fnlfmt]
                          :markdown [:dprint]}})))

;; Snippets ======================================================================
;;
;; Although 'mini.snippets' provides functionality to manage snippet files, it
;; deliberately doesn't come with those.
;;
;; The 'rafamadriz/friendly-snippets' is currently the largest collection of
;; snippet files. They are organized in 'snippets/' directory (mostly) per language.
;; 'mini.snippets' is designed to work with it as seamlessly as possible.
;; See `:h MiniSnippets.gen_loader.from_lang()`.
;; (later (fn [] nil))

;; Honorable mentions ============================================================
;;
;; 'mason-org/mason.nvim' (a.k.a. "Mason") is a great tool (package manager) for
;; installing external language servers, formatters, and linters. It provides
;; a unified interface for installing, updating, and deleting such programs.
;;
;; The caveat is that these programs will be set up to be mostly used inside Neovim.
;; If you need them to work elsewhere, consider using other package managers.
;;
;; You can use it like so:
;; (now_if_args
;;   (fn []
;;     (add {1 :https://github.com/mason-org/mason.nvim})
;;     ((. (require :mason) :setup))))

;; Beautiful, usable, well maintained color schemes outside of 'mini.nvim' and
;; have full support of its highlight groups. Use if you don't like 'miniwinter'
;; enabled in 'plugin/30_mini.lua' or other suggested 'mini.hues' based ones.
;; (Config.now
;;   (fn []
;;    ;; Install only those that you need
;;    (add {1 :https://github.com/sainnhe/everforest
;;          2 :https://github.com/Shatur/neovim-ayu
;;          3 :https://github.com/ellisonleao/gruvbox.nvim})
;;
;;    ;; Enable only one
;;    (vim.cmd "color everforest")))

;; LazyDev for easy neovim config writing
(now_if_args
  (fn []
    ((. (require :lazydev) :setup)
     {:library [{:path :mini.nvim :words [:Mini%u%w+]}]})))

;; Indentation detection =========================================================
;;
;; 'nmac427/guess-indent.nvim' inspects a buffer's existing indentation and sets
;; 'shiftwidth'/'expandtab' to match, overriding whatever 10_options.lua set as
;; the global default on a per-file basis.
(now_if_args (fn [] ((. (require :guess-indent) :setup) {})))
