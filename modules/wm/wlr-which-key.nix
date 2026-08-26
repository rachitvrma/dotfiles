{
  flake.homeModules.wlr-which-key = { config, ... }: {
    programs.wlr-which-key =
      let
        commonSettings = {
          font = "monospace 12";
          background = config.lib.stylix.colors.withHashtag.base00 + "d0";
          color = config.lib.stylix.colors.withHashtag.base05;
          border = config.lib.stylix.colors.withHashtag.base0E;

          border_width = 2;
          corner_r = 10;
          rows_per_column = 25;
          anchor = "bottom-right";

          inhibit_compositor_keyboard_shortcuts = true;
        };
      in
      {
        enable = true;
        settings = commonSettings // {
          menu = [
            {
              key = "e";
              desc = "Equibop";
              cmd = "systemd-run --user equibop";
            }
            {
              key = "m";
              desc = "Iamb Matrix";
              cmd = "systemd-run --user kitty --title=iamb_matrix -e iamb";
            }
            {
              key = "E";
              desc = "Elment Desktop";
              cmd = "systemd-run --user element-desktop";
            }
            {
              key = "h";
              desc = "Halloy IRC Client";
              cmd = "systemd-run --user halloy";
            }
            {
              key = "k";
              desc = "Kotatogram";
              cmd = "systemd-run --user Kotatogram";
            }
          ];
        };

        extraMenus = {
          filemanagers = commonSettings // {
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

          powermenu = commonSettings // {
            menu = [
              {
                key = "p";
                desc = "Power Off";
                cmd = "noctalia msg session shutdown || systemctl poweroff";
              }
              {
                key = "r";
                desc = "Reboot";
                cmd = "noctalia msg session reboot || systemctl reboot";
              }
              {
                key = "l";
                desc = "Lock";
                cmd = "noctalia msg session lock || loginctl lock-session";
              }
            ];
          };

          # Panels comprising of various noctalia launcher options
          noctalia-panels = commonSettings // {
            menu = [
              {
                key = "c";
                desc = "Clipboard";
                cmd = "noctalia msg panel-toggle clipboard";
              }
              {
                key = "space";
                desc = "Launcher";
                cmd = "noctalia msg panel-toggle launcher";
              }
              {
                key = "e";
                desc = "Emojis";
                cmd = "noctalia msg panel-toggle launcher /emo";
              }
              {
                key = "k";
                desc = "Kaomoji";
                cmd = "noctalia msg panel-toggle launcher /kao";
              }
            ];
          };
        };
      };
  };
}
