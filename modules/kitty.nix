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

          background_opacity = 0.8;
          background_blur = 64;

          background = "#141617";
          cursor_text_color = "#141617";
          active_tab_foreground = "#141617";

          allow_remote_control = true;
          listen_on = "unix:/tmp/kitty";
          enabled_layouts = "splits";

          tab_bar_style = "powerline";
          tab_powerline_style = "round";
          tab_bar_min_tabs = 2;
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
