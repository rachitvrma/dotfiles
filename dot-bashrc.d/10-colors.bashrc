# -*- mode: sh; sh-shell: bash -*-
# Vivid LS_COLORS, cached so `vivid` is not forked on every shell start.
# Regenerated when the cache is missing/empty or the vivid binary is newer.
if have vivid; then
	_lsc_cache="${XDG_CACHE_HOME:-$HOME/.cache}/ls_colors.one-dark"
	if [[ ! -s $_lsc_cache || $(command -v vivid) -nt $_lsc_cache ]]; then
		mkdir -p "${_lsc_cache%/*}"
		vivid generate one-dark >"$_lsc_cache"
	fi
	LS_COLORS=$(<"$_lsc_cache")
	export LS_COLORS
	unset -v _lsc_cache
fi
