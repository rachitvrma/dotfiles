{
  flake.homeModules.kitty = { pkgs, ... }: {
    xdg.terminal-exec = {
      enable = true;
      settings = {
        default = [ "kitty.desktop" ];
      };
    };
    programs = {
      kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration.enableFishIntegration = true;
        font = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
          size = 11.5;
        };
        themeFile = "GruvboxMaterialDarkHard";
        settings = {
          cursor_trail = 10;
          cursor_trail_decay = "0.1 0.4";
          cursor_trail_start_threshold = 2;
          scrollback_lines = 10000;
          scrollback_pager = "nvim --cmd 'set eventignore=FileType' +'nnoremap q ZQ' +'call nvim_open_term(0, {})' +'set nomodified nolist' +'$' -";
          visual_bell_duration = 0.1;
          window_padding_width = 15;
          notify_on_cmd_finish = "unfocused";

          background_opacity = 0.85;
          background_blur = 64;

          background = "#141617";
          cursor_text_color = "#141617";
          active_tab_foreground = "#141617";

          allow_remote_control = true;
          listen_on = "unix:/tmp/kitty";
          # enabled_layouts = "splits";

          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          tab_bar_align = "left";
          tab_bar_min_tabs = 2;
          tab_bar_margin_width = 0.0;
          tab_bar_margin_height = "2.5 1.5";
          tab_bar_margin_color = "#1d2021";
          tab_bar_background = "#1d2021";

          active_tab_background = "#d3869b";
          active_tab_font_style = "bold";

          inactive_tab_font_style = "normal";

          tab_activity_symbol = " ● ";

          tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title[:30]}{title[30:] and '…'} [{index}]";
          active_tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title[:30]}{title[30:] and '…'} [{index}]";
        };

        keybindings = {
          "kitty_mod+enter" = "new_window_with_cwd";
          "kitty_mod+n" = "new_os_window_with_cwd";
          "kitty_mod+t" = "new_tab_with_cwd";
        };

        diffConfig = {
          settings.diff_cmd = "auto";
          keybindings = {
            "j" = "scroll_by 1";
          };
        };
      };
    };
  };
}
