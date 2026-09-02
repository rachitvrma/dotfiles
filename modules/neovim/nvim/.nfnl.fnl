;; `fnl/**/*.fnl` mirrors into `lua/` (for modules loaded via `require`, e.g.
;; the lz.n plugin specs in `fnl/lazy/`). `plugin/**/*.fnl` compiles in place
;; (next to its `.lua` sibling) since Neovim auto-sources `plugin/*.lua` by
;; filename, not via `require`. `init.fnl` and `after/**/*.fnl` are always
;; covered by nfnl's defaults and compile in place too.
{:source-file-patterns [:fnl/**/*.fnl :plugin/**/*.fnl]}
{:compiler-options {:compilerEnv _G}}
