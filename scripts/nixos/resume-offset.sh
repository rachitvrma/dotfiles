#!/usr/bin/env bash
# Print the physical resume offset of the swapfile, for resumeOffset in
# modules/hosts/nixpavilion/_hibernation.nix. Only needed if hibernation does
# not resume with the default (offset-less) setup.
set -euo pipefail
sudo btrfs inspect-internal map-swapfile -r /.swapvol/swapfile
