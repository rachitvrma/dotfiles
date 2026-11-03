#!/usr/bin/env bash
# Add the btrfs swapfile that modules/hosts/nixpavilion/_disko-config.nix
# declares to a system that was installed BEFORE that declaration existed.
# (A fresh `disko` install creates it by itself; do not run this then.)
#
# Run as root BEFORE `nixos-rebuild switch`, otherwise the new /.swapvol mount
# fails at boot. Usage: sudo add-swapfile.sh [size]   (default 24G, must match
# swap.swapfile.size in the disko config)
set -euo pipefail

size="${1:-24G}"
dev=/dev/mapper/crypted

mnt="$(mktemp -d)"
trap 'umount "$mnt" 2>/dev/null || true; rmdir "$mnt"' EXIT

# subvolid=5 is the top level of the filesystem, where subvolumes are created.
mount -o subvolid=5 "$dev" "$mnt"
btrfs subvolume create "$mnt/swap"
umount "$mnt"

mkdir -p /.swapvol
mount -o noatime,subvol=/swap "$dev" /.swapvol
# Creates a NOCOW, uncompressed, preallocated file and formats it as swap.
btrfs filesystem mkswapfile --size "$size" /.swapvol/swapfile
echo "Done. Now: nixos-rebuild switch (swap is activated by the new config)."
