# vivid LS_COLORS, cached like bashrc.d/10-colors.bashrc (same cache file, so
# bash and fish share it). Regenerated when the cache is missing or empty, or
# when the vivid binary is newer than the cache.
status is-interactive; or return
type -q vivid; or return

set -l cache $XDG_CACHE_HOME/ls_colors.vivid
if not test -s $cache; or test (command -s vivid) -nt $cache
    mkdir -p (path dirname $cache)
    vivid generate gruvbox-dark-hard >$cache
end
set -gx LS_COLORS (string collect <$cache)
