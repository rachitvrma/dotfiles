{
  flake.homeModules.zathura = {
    programs.zathura = {
      enable = true;
      options = {
        font = "monospace normal 11";

        # Base UI
        # default-bg = "#141617"; # base00
        default-bg = "#1d2021";
        default-fg = "#ddc7a1"; # base05

        # Statusbar (bottom bar showing page number, filename, etc.)
        statusbar-fg = "#ddc7a1"; # base05
        statusbar-bg = "#1d2021"; # base01

        # Inputbar (command/search input line)
        inputbar-fg = "#fbf1c7"; # base07
        inputbar-bg = "#282828"; # base02

        # Notifications
        notification-fg = "#ebdbb2"; # base06
        notification-bg = "#282828"; # base02
        notification-error-fg = "#141617"; # base00 — dark text on red for contrast
        notification-error-bg = "#ea6962"; # base08
        notification-warning-fg = "#141617"; # base00
        notification-warning-bg = "#e78a4e"; # base09

        # Completion (command-mode autocomplete list, e.g. `:open`)
        completion-bg = "#1d2021"; # base01
        completion-fg = "#bdae93"; # base04
        completion-group-bg = "#282828"; # base02
        completion-group-fg = "#a9b665"; # base0B — subtle differentiator, not the main accent
        completion-highlight-bg = "#d3869b"; # base0E — magenta, matches your Sway/bar accent
        completion-highlight-fg = "#141617"; # base00

        # Table of contents / index sidebar
        index-fg = "#ddc7a1"; # base05
        index-bg = "#141617"; # base00
        index-active-fg = "#141617"; # base00 — dark text on magenta for contrast
        index-active-bg = "#d3869b"; # base0E — magenta, current selection

        # In-document search highlighting
        highlight-color = "#d3869b"; # base0E — magenta, matches the accent theme
        highlight-active-color = "#7daea3"; # base0D — secondary accent, distinguishes "current match" from "all matches"

        # Recoloring mode (the `:recolor` toggle that re-tints the whole PDF, useful for dark-mode reading)
        recolor = true;
        recolor-lightcolor = "#141617"; # base00 — becomes the "page background" when recolor is on
        recolor-darkcolor = "#ddc7a1"; # base05 — becomes the "ink/text" color when recolor is on
        recolor-keephue = false; # set true if you want images to keep their original hues instead of full invert

        selection-clipboard = "clipboard";
      };

      # These are emacs keybindings
      # TODO: make a module to enable/disable emacs keybindings
      /*
        mappings = {
          # Scrolling — mirrors Emacs' C-v / M-v / C-n / C-p for vertical movement
          "<C-v>" = "scroll full-down"; # Emacs C-v: scroll-down (page forward)
          "<A-v>" = "scroll full-up"; # Emacs M-v: scroll-up (page backward). Zathura uses <A-> for Alt/Meta, not <M->
          "<C-n>" = "scroll down"; # Emacs C-n: next line -> here, small downward scroll
          "<C-p>" = "scroll up"; # Emacs C-p: previous line -> small upward scroll

          # Page navigation — closer to doc-view-mode's actual bindings than raw Emacs
          "<C-f>" = "navigate next"; # next page (doc-view-mode: n / C-n)
          "<C-b>" = "navigate previous"; # previous page (doc-view-mode: p / C-p)

          # Search — Emacs isearch equivalents
          "<C-s>" = "search forward"; # Emacs C-s: isearch-forward
          "<C-r>" = "search backward"; # Emacs C-r: isearch-backward

          # Buffer boundaries — Emacs M-< / M-> (beginning/end of buffer)
          "<A-less>" = "goto top"; # M-< : jump to first page. Zathura has no literal '<' keysym name; "less" is the key name for the < character
          "<A-greater>" = "goto bottom"; # M-> : jump to last page; "greater" = the > character

          # Abort — Emacs' universal C-g cancels any pending command/prompt
          "<C-g>" = "abort";
        };
      */
    };
  };
}
