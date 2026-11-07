# Dotfiles (GNU Stow) and NixOS tasks.
# Recipe lines must start with a TAB, not spaces.

SHELL       := bash
.SHELLFLAGS := -euo pipefail -c

HOST     := nixpavilion
STOW     ?= stow
PACKAGES := $(notdir $(wildcard stow/*))

STOW_TARGETS   := $(addprefix stow-,$(PACKAGES))
UNSTOW_TARGETS := $(addprefix unstow-,$(PACKAGES))

.PHONY: all install uninstall check update fmt \
        build switch nixos-install resume-offset \
        $(STOW_TARGETS) $(UNSTOW_TARGETS)

# Plain `make` builds the system without switching.
all: build

# --- dotfiles ---------------------------------------------------------------

# make install        stow every package under stow/
# make stow-fish      stow one package
# make install STOW="stow -nv"   simulate, to check for conflicts first
install: $(STOW_TARGETS)
	@for d in ~/.gnupg ~/.ssh; do [ -d "$$d" ] && chmod 700 "$$d" || true; done
	@echo "===Dotfiles Installed==="

# Conflicting files are moved to *.pre-stow before stowing.
$(STOW_TARGETS): stow-%:
	./scripts/backup-conflicts.sh $*
	$(STOW) $*

uninstall: $(UNSTOW_TARGETS)

$(UNSTOW_TARGETS): unstow-%:
	$(STOW) -D $*

# --- NixOS ------------------------------------------------------------------

# Evaluate and build the system without switching.
build:
	nh os build . -H $(HOST)

switch:
	nh os switch . -H $(HOST)

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
nixos-install:
	sudo nix run github:nix-community/disko -- --mode destroy,format,mount --flake .#$(HOST)
	sudo nixos-install --flake .#$(HOST)

# Only needed if hibernation does not resume (see _hibernation.nix).
resume-offset:
	./scripts/nixos/resume-offset.sh
