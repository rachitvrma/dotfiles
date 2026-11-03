#!/usr/bin/env bash
set -euo pipefail

if command -v paru &>/dev/null; then
  echo "paru is already installed"
  exit 0
fi

if [ "$EUID" -eq 0 ]; then
  echo "run this as a normal user, makepkg refuses to run as root" >&2
  exit 1
fi

workdir="$(mktemp -d /tmp/paru-build.XXXXXX)"
trap 'cd /; rm -rf -- "$workdir"' EXIT
export CARGO_HOME="$workdir/cargo"

cd "$workdir"
sudo pacman -S --needed base-devel git
git clone --depth=1 https://aur.archlinux.org/paru.git
cd paru
# review PKGBUILD here if you want: less PKGBUILD
makepkg -si


