# Editor and shell behaviour. Counterpart of dot-bashrc (EDITOR) and
# 20-shell-options.bashrc.

# Terminal frame (-t) over SSH or without a display, GUI frame (-c) otherwise.
# -a '' (empty alternate editor) starts the Emacs daemon on demand.
if set -q SSH_CONNECTION; or begin
        not set -q WAYLAND_DISPLAY; and not set -q DISPLAY
    end
    set -gx EDITOR "emacsclient -t -a ''"
else
    set -gx EDITOR "emacsclient -c -a ''"
end
set -gx VISUAL $EDITOR

set -gx MANROFFOPT -c
type -q bat; and set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -g __done_min_cmd_duration 10000
set -g __done_notification_urgency_level low

status is-interactive; or return

# GPG needs to know the terminal for pinentry
set -gx GPG_TTY (tty)

# History: fish already de-duplicates and writes to
# $XDG_DATA_HOME/fish/fish_history, so HISTCONTROL/histappend have no
# equivalent. HISTIGNORE: use `history delete` or a leading space instead.


