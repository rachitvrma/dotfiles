#!/usr/bin/env bash
# Move files in $HOME that would conflict with a stow package out of the way
# (to <file>.pre-stow). Usage: backup-conflicts.sh [package...]  (default: all)
set -euo pipefail
cd "$(dirname "$0")/.."

pkgs=("$@")
if [ ${#pkgs[@]} -eq 0 ]; then
	for d in dotfiles/*/; do
		pkgs+=("$(basename "$d")")
	done
fi

# stow --dotfiles turns a leading "dot-" in EACH path component into ".".
# (The old ${rel//dot-/.} replaced every "dot-" anywhere in the path.)
to_target() {
	local rel="$1" part out=""
	local -a parts
	IFS=/ read -ra parts <<<"$rel"
	for part in "${parts[@]}"; do
		# Glob (not regex) pattern: "dot-" followed by anything.
		if [[ $part == dot-* ]]; then
			part=".${part#dot-}"
		fi
		out+="/$part"
	done
	printf '%s\n' "$HOME$out"
}

for pkg in "${pkgs[@]}"; do
	while IFS= read -r -d '' src; do
		rel="${src#dotfiles/$pkg/}"
		target="$(to_target "$rel")"
		if [ -e "$target" ] || [ -L "$target" ]; then
			if [ "$(readlink -f "$target")" != "$(readlink -f "$src")" ]; then
				mv -v -- "$target" "$target.pre-stow"
			fi
		fi
	done < <(find "dotfiles/$pkg" -type f -print0)
done
