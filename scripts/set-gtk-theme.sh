#!/usr/bin/env bash
set -euo pipefail

# NOTE: Sync this with NixOS's dconf modules

gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Set Emacs bindings for GTK
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

# Filechooser: start in cwd
gsettings set org.gtk.Settings.FileChooser startup-mode cwd

# Change the gtk keymap
gsettings set org.gnome.desktop.input-sources xkb-options 'ctrl:swapcaps'
