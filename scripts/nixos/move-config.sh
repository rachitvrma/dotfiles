#!/usr/bin/env bash
# Move the installer-generated /etc/nixos to ~/etc/nixos (where this repo
# lives) and leave a symlink behind.
set -euo pipefail

mkdir -p ~/etc
sudo mv /etc/nixos ~/etc/
sudo chown -R "$(id -un):$(id -gn)" ~/etc/nixos
sudo ln -sfn ~/etc/nixos /etc/nixos
