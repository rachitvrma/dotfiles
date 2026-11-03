# Tool initialisation. Loaded last. Counterpart of 90-init.bashrc.
status is-interactive; or return

# Nix integration
type -q nix-your-shell; and nix-your-shell fish | source

# Television: shell integration (key bindings)
type -q tv; and tv init fish | source

# Carapace: multi-shell completions
type -q carapace; and carapace _carapace fish | source

# pay-respects: fix the previous command
type -q pay-respects; and pay-respects fish --alias | source

# fzf: options only; key bindings stay with television (Ctrl-T / Ctrl-R)
type -q fzf; and set -gx FZF_DEFAULT_OPTS '--height 40% --prompt "⟫ "'

# Starship prompt
type -q starship; and starship init fish | source

# Direnv
type -q direnv; and direnv hook fish | source

# Zoxide (keep last)
type -q zoxide; and zoxide init fish | source


