# -*- mode: sh; sh-shell: bash -*-
_ud="${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"
if [[ -r $_ud ]]; then
	set -a
	. "$_ud"
	set +a
fi
unset -v _ud