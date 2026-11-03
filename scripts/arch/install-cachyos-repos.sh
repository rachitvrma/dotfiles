#!/usr/bin/env bash
set -euo pipefail

workdir="$(mktemp -d /tmp/cachyos-repo.XXXXXX)"
cleanup() {
  cd /
  rm -rf -- "$workdir" 2>/dev/null || sudo rm -rf -- "$workdir"
}
trap cleanup EXIT

cd "$workdir"
curl -fsSL https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xf cachyos-repo.tar.xz
cd cachyos-repo
sudo ./cachyos-repo.sh
echo "To uninstall the CachyOS repos, see https://wiki.cachyos.org/features/optimized_repos/#uninstalling-cachyos-repositories"
