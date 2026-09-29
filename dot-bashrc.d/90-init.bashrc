# -*- mode: sh; sh-shell: bash -*-
# Tool initialisation. Loaded last on purpose: starship, direnv and zoxide all
# hook PROMPT_COMMAND, and zoxide should come after the others.

# Television: shell integration (key bindings)
if have tv; then
	eval "$(tv init bash)"
fi

# Starship prompt
if have starship; then
	eval "$(starship init bash)"
fi

# Direnv
if have direnv; then
	eval "$(direnv hook bash)"
fi

# Zoxide (keep last)
if have zoxide; then
	eval "$(zoxide init bash)"
fi
