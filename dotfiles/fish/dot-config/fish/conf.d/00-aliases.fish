# Aliases. Counterpart of bashrc.d/00-aliases.bashrc.
# `alias` in fish defines a small function. Only interactive shells need them.
status is-interactive; or return

if type -q eza
    alias ls='eza -al --color=always --group-directories-first --icons=auto' # preferred listing
    alias la='eza -a --color=always --group-directories-first --icons=auto' # all files and dirs
    alias ll='eza -l --color=always --group-directories-first --icons=auto' # long format
    alias lt='eza -aT --color=always --group-directories-first --icons=auto' # tree listing
    alias l.="eza -a | grep -e '^\.'" # show only dotfiles
end

alias l 'ls -alh'

alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

alias ex vim
alias vi vim
alias nano vim

type -q bat; and alias cat 'bat --paging=never'
type -q fastfetch; and alias ff fastfetch
type -q sl; and alias sl 'sl -dFGl'

# remacs is a function: functions/remacs.fish

# Common aliases, picked from the cachyos fish config
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias hist 'history --show-time="%F %T "'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"
