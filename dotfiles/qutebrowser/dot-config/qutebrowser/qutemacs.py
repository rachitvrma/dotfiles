# qutemacs - Emacs-style bindings for qutebrowser.
#
# Migrated from the NixOS config (modules/browsers/qutebrowser/module.nix).
# Based on the upstream qutemacs binding set, extended with C-x prefixed tab
# and window commands, a few Emacs-style extras and the insert/prompt modes.
#
# Loaded from config.py with: config.source('qutemacs.py')

config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

# Disable automatic insert mode. Insert mode is entered by hand with <ctrl-m>.
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.input.insert_mode.plugins = False

# Forward keys that have no binding to the page.
c.input.forward_unbound_keys = "all"

ESC_BIND = "clear-keychain ;; search ;; fullscreen --leave"

# Wipe the default bindings of NORMAL mode only. Setting
# c.bindings.default = {} would also wipe hint, command, prompt and caret.
c.bindings.default["normal"] = {}

c.bindings.commands["normal"] = {
    # Navigation
    "<ctrl-v>": "scroll-page 0 0.5",
    "<alt-v>": "scroll-page 0 -0.5",
    "<ctrl-shift-v>": "scroll-page 0 1",
    "<alt-shift-v>": "scroll-page 0 -1",
    "<alt-shift-,>": "scroll-to-perc 0",
    "<alt-shift-.>": "scroll-to-perc",
    # FIXME: come up with logical bindings for scrolling left/right

    # Files, reloading and config
    "<ctrl-x><ctrl-f>": "cmd-set-text -s :open -t",
    "<ctrl-u><ctrl-x><ctrl-f>": "cmd-set-text -s :open",
    "<ctrl-x>l": "reload",
    "<ctrl-x>xg": "config-source",

    # Ctrl-M is Return in ASCII. This is a NORMAL mode binding that enters
    # insert mode, since automatic insert mode is disabled above.
    "<ctrl-m>": "mode-enter insert",

    # Tabs
    "<ctrl-x>0": "tab-close",
    "<ctrl-x>1": "tab-only",
    "<ctrl-x>k": "tab-close",  # redundant with <ctrl-x>0, harmless
    "<alt-a>": "tab-prev",
    "<alt-e>": "tab-next",
    "<ctrl-tab>": "tab-next",
    "<ctrl-shift-tab>": "tab-prev",

    # Hinting
    "<ctrl-space>": "hint all",
    "<ctrl-u><ctrl-space>": "hint --rapid links tab-bg",

    # Commands
    "<alt-x>": "cmd-set-text :",
    # `buffer` is a deprecated alias of `tab-select`. This only prefills the
    # command line, so it still works.
    "<ctrl-x>b": "cmd-set-text -s :buffer",
    "<ctrl-x><ctrl-c>": "quit",

    # Searching
    "<ctrl-s>": "cmd-set-text /",
    "<ctrl-r>": "cmd-set-text ?",

    # Yanking
    "<alt-w>": "yank",
    "<ctrl-u><alt-w>d": "yank domain",
    "<ctrl-u><alt-w>p": "yank pretty-url",
    "<ctrl-u><alt-w>t": "yank title",

    # mpv. These bindings are quite dissimilar from the other bindings.
    "<Ctrl+/>v": "spawn --detach mpv {url}",
    "<Ctrl+/>V": "hint links spawn --detach mpv {hint-url}",

    # History
    "<ctrl-]>": "forward",
    "<ctrl-[>": "back",

    # Open links
    "<ctrl-l>": "cmd-set-text -s :open",
    "<alt-l>": "cmd-set-text -s :open -t",

    # Editing
    "<ctrl-f>": "fake-key <Right>",
    "<ctrl-b>": "fake-key <Left>",
    "<ctrl-a>": "fake-key <Home>",
    "<ctrl-e>": "fake-key <End>",
    "<ctrl-n>": "fake-key <Down>",
    "<ctrl-p>": "fake-key <Up>",
    "<alt-f>": "fake-key <Ctrl-Right>",
    "<alt-b>": "fake-key <Ctrl-Left>",
    "<ctrl-d>": "fake-key <Delete>",
    "<alt-d>": "fake-key <Ctrl-Delete>",
    "<alt-backspace>": "fake-key <Ctrl-Backspace>",
    "<ctrl-w>": "fake-key <Ctrl-backspace>",
    "<ctrl-y>": "insert-text {primary}",

    # Numbers
    # https://github.com/qutebrowser/qutebrowser/issues/4213
    "1": "fake-key 1",
    "2": "fake-key 2",
    "3": "fake-key 3",
    "4": "fake-key 4",
    "5": "fake-key 5",
    "6": "fake-key 6",
    "7": "fake-key 7",
    "8": "fake-key 8",
    "9": "fake-key 9",
    "0": "fake-key 0",

    # Escape hatch
    "<ctrl-h>": "cmd-set-text -s :help",
    "<ctrl-g>": ESC_BIND,
}

c.bindings.commands["insert"] = {
    "<ctrl-e>": "open-editor",
    "<escape>": "mode-leave",
    "<ctrl-g>": "mode-leave",
}

c.bindings.commands["command"] = {
    "<ctrl-s>": "search-next",
    "<ctrl-r>": "search-prev",

    "<ctrl-p>": "completion-item-focus prev",
    "<ctrl-n>": "completion-item-focus next",

    "<alt-p>": "command-history-prev",
    "<alt-n>": "command-history-next",

    "<ctrl-g>": "mode-leave",
    "<escape>": "mode-leave",

    "<return>": "command-accept",
    "<ctrl-m>": "command-accept",
}

c.bindings.commands["hint"] = {
    "<escape>": "mode-leave",
    "<ctrl-g>": "mode-leave",
    "<return>": "follow-hint",
    "<ctrl-m>": "follow-hint",
}

c.bindings.commands["prompt"] = {
    "<ctrl-p>": "prompt-item-focus prev",
    "<ctrl-n>": "prompt-item-focus next",

    "<ctrl-g>": "mode-leave",
    "<escape>": "mode-leave",

    "<ctrl-m>": "prompt-accept",
    "<return>": "prompt-accept",

    "n": "prompt-accept no",
    "y": "prompt-accept yes",
}

c.bindings.commands["caret"] = {
    "<ctrl-g>": "mode-leave",
}


