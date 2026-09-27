# -*- mode: sh; sh-shell: bash -*-
if command -v eza &>/dev/null; then
	alias ls='eza --group-directories-first --color=auto --icons=auto'
fi

alias l='ls -l'
alias '..'='cd ..'
alias '...'='cd ../..'

  alias vim='nvim'
  alias vi='nvim'
  alias ex='nvim'
  alias nano='nvim'

