# -*- mode: sh; sh-shell: bash -*-
# Interactive shell options and history behaviour.

shopt -s histappend extglob globstar checkjobs cdspell autocd

HISTCONTROL=erasedups
# home-manager's bash module defaulted to these; bash itself defaults to 500.
HISTSIZE=10000
HISTFILESIZE=100000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/bash/history"
mkdir -p "${HISTFILE%/*}"
HISTIGNORE='ls:cd:exit'

# GPG needs to know the terminal for pinentry
export GPG_TTY="$(tty)"


