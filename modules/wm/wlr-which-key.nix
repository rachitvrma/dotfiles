{
  flake.homeModules.wlr-which-key = {
    programs.wlr-which-key = {
      enable = true;
      settings = {
        font = "JetBrainsMono Nerd Font 12";
        # Gruvbox theme
        background = "#141617d0";
        color = "#ddc7a1";
        border = "#d3869b";

        border_width = 2;
        corner_r = 10;
        rows_per_column = 25;
        anchor = "bottom-right";

        inhibit_compositor_keyboard_shortcuts = true;

        menu = [
          {
            key = "c";
            desc = "clipboard";
            cmd = "noctalia msg panel-toggle clipboard";
          }
          {
            key = "Return";
            desc = "Terminal";
            cmd = "xdg-terminal-exec || systemd-run --user kitty";
          }
        ];
      };

      extraMenus = {
        browsers = {
          font = "monospace 12";
          background = "#141617d0";
          color = "#ddc7a1";
          border = "#d3869b";

          border_width = 2;
          corner_r = 10;
          rows_per_column = 5;
          column_padding = 25;
          anchor = "bottom-right";

          inhibit_compositor_keyboard_shortcuts = true;

          menu = [
            {
              key = "f";
              desc = "Firefox";
              cmd = "systemd-run --user firefox";
            }
            {
              key = "q";
              desc = "Qutebrowser";
              cmd = "systemd-run --user qutebrowser";
            }
          ];
        };

        filemanagers = {
          font = "monospace 12";
          background = "#141617d0";
          color = "#ddc7a1";
          border = "#d3869b";

          border_width = 2;
          corner_r = 10;
          rows_per_column = 5;
          column_padding = 25;
          anchor = "bottom-right";

          inhibit_compositor_keyboard_shortcuts = true;

          menu = [
            {
              key = "e";
              desc = "Yazi";
              cmd = "systemd-run --user kitty --title=yazi_filemanager -e yazi";
            }
            {
              key = "E";
              desc = "PcmanFm";
              cmd = "systemd-run --user pcmanfm";
            }
          ];
        };
      };
    };
  };
}
