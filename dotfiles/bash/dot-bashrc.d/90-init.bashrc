# -*- mode: sh; sh-shell: bash -*-
# Tool initialisation. Loaded last on purpose: starship, direnv and zoxide all
# hook PROMPT_COMMAND, and zoxide should come after the others.

# Let's make it look good
if have fastfetch; then
  fastfetch
fi

# Television: shell integration (key bindings)
if have tv; then
  eval "$(tv init bash)"
fi

# Carapace: multi-shell completions
if have carapace; then
  source <(carapace _carapace bash)
fi

# pay-respects: fix the previous command
if have pay-respects; then
  eval "$(pay-respects bash --alias)"
fi

# fzf: options only; key bindings stay with television (Ctrl-T / Ctrl-R)
if have fzf; then
  export FZF_DEFAULT_OPTS='--height 40% --prompt ⟫ '
fi

# Starship prompt
if have starship; then
  eval "$(starship init bash)"
fi

# Direnv
if have direnv; then
  eval "$(direnv hook bash)"
fi

# Nix Devenv initialization
if have devenv; then
  eval "$(devenv hook bash)"
fi

# Zoxide (keep last)
if have zoxide; then
  eval "$(zoxide init bash)"
fi
