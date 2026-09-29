# -*- mode: sh; sh-shell: bash -*-
if have eza; then
	alias ls='eza --group-directories-first --color=auto --icons=auto'
fi

alias l='ls -l'
alias ll='ls -l'
alias la='ls -al'

alias ..='cd ..'
alias ...='cd ../..'
alias ex='vim'
alias vi='vim'
alias nano='vim'

if have bat; then
    alias cat='bat --paging=never'
fi
