{
  flake.homeModules.kitty = { ... }: {
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
        shellIntegration.enableZshIntegration = true;
        settings = {
          cursor_trail = 10;
          cursor_trail_decay = "0.1 0.4";
          cursor_trail_start_threshold = 2;

          scrollback_lines = 5000;
          scrollback_pager = "nvim --cmd 'set eventignore=FileType' +'nnoremap q ZQ' +'call nvim_open_term(0, {})' +'set nomodified nolist' +'$' -";
          scrollback_pager_history_size = 10;

          mouse_hide_wait = -3.0;

          remember_window_size = true;
          initial_window_width = 800;
          initial_window_height = 400;

          hide_window_decorations = true;

          enable_audio_bell = false;
          bell_on_tab = "🔔 ";
          visual_bell_duration = 0.1;
          window_padding_width = 15;
          notify_on_cmd_finish = "invisible 20";
          background_tint = 0.35;
          background_tint_gaps = 0.5;
          dynamic_background_opacity = true;
          background_blur = 64;

          allow_remote_control = true;
          listen_on = "unix:/tmp/kitty";
          # enabled_layouts = "splits";

          tab_bar_edge = "bottom";
          tab_bar_style = "powerline";
          tab_powerline_style = "round";
          tab_bar_align = "left";
          tab_bar_min_tabs = 2;
          tab_bar_margin_width = 0.0;
          tab_bar_margin_height = "2.5 1.5";
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
