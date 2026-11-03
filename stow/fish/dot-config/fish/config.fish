# test -f /usr/share/cachyos-fish-config/cachyos-config.fish; and source /usr/share/cachyos-fish-config/cachyos-config.fish

# Intentionally almost empty. fish sources every file in conf.d/ in
# alphabetical order before this file, and loads functions/ and completions/
# on demand. Put things in conf.d/NN-name.fish, not here.
# Mirrors the bash layout: ~/.bashrc.d/NN-name.bashrc <-> conf.d/NN-name.fish.
# Keep fish_variables (written by fish itself) out of the repo.

# The greeting lives in functions/fish_greeting.fish.


