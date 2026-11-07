# -*- mode: sh; sh-shell: bash -*-
# Respect a value already set by the session (see environment.d/10-xdg.conf),
# otherwise fall back to the spec defaults.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Programs that home.preferXdgDirectories used to move out of $HOME.
# See also environment.d/10-xdg.conf (same CARGO_HOME for GUI sessions).
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
mkdir -p "${LESSHISTFILE%/*}"


