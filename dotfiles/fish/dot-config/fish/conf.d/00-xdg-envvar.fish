# XDG base directories. Respect a value already set by the session
# (environment.d/10-xdg.conf), otherwise use the spec defaults.
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME $HOME/.local/state

# Programs moved out of $HOME (same values as bashrc.d/00-xdg-envvars.bashrc)
set -q CARGO_HOME; or set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx LESSHISTFILE $XDG_STATE_HOME/less/history
mkdir -p (path dirname $LESSHISTFILE)


