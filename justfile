set shell := ["bash", "-euo", "pipefail", "-c"]

host := "nixpavilion"

default:
    @just --list

# --- dotfiles (GNU Stow) ----------------------------------------------------

# Install one stow package, moving conflicting files to *.pre-stow first.
stow pkg:
    ./scripts/backup-conflicts.sh {{pkg}}
    stow {{pkg}}
    @just perms

stow-all:
    ./scripts/backup-conflicts.sh
    stow $(ls stow)
    @just perms
    @echo "===Dotfiles Installed==="

unstow pkg:
    stow -D {{pkg}}

restow pkg:
    stow -R {{pkg}}

# gpg and ssh refuse (or warn about) group/world accessible directories, and
# stow creates them with the default umask.
perms:
    @for d in ~/.gnupg ~/.ssh; do [ -d "$d" ] && chmod 700 "$d" || true; done

# --- NixOS ------------------------------------------------------------------

# Evaluate and build the system without switching.
build:
    nh os build . -H {{host}}

switch:
    nh os switch . -H {{host}}

# Every flake output, evaluated (catches option typos before a switch).
check:
    nix flake check --no-build

# Inputs are pinned by tack (.tack/pins.toml), not by a flake.lock.
update:
    tack update

fmt:
    nix fmt

# Install onto a blank disk: partitions, encrypts, creates the swapfile.
# DESTROYS /dev/nvme0n1. Run from the NixOS installer.
install:
    sudo nix run github:nix-community/disko -- --mode destroy,format,mount --flake .#{{host}}
    sudo nixos-install --flake .#{{host}}

# Only needed if hibernation does not resume (see _hibernation.nix).
resume-offset:
    ./scripts/nixos/resume-offset.sh
