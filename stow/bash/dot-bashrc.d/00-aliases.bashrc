# -*- mode: sh; sh-shell: bash -*-
if have eza; then
	alias ls='eza --group-directories-first --header --color=auto --icons=auto'
	alias lt='eza --tree --group-directories-first --color=auto --icons=auto'
fi

alias l='ls -l'
alias ll='ls -l'
alias la='ls -al'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ..='cd ..'
alias ...='cd ../..'
alias ex='vim'
alias vi='vim'
alias nano='vim'

if have bat; then
    alias cat='bat --paging=never'
fi

if have fastfetch; then
	alias ff='fastfetch'
fi

if have sl; then
	alias sl='sl -dFGl'
fi

# Restart the Emacs daemon (user service shipped with the emacs package)
alias remacs='systemctl --user restart emacs.service'


