#!/usr/bin/env bash
set -euo pipefail

sudo localectl set-keymap --no-convert mod-dh-ansi-us
sudo localectl set-x11-keymap --no-convert us "" colemak_dh "ctrl:swapcaps"
