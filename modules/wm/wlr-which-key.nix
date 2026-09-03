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
              key = "m";
              desc = "Iamb Matrix";
              cmd = "systemd-run --user kitty --title=iamb_matrix -e iamb";
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
            {
              key = "v";
              desc = "vesktop";
              cmd = "systemd-run --user vesktop";
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
              {
                key = "x";
                desc = "Session Menu";
                cmd = "noctalia msg panel-toggle launcher /session";
              }
            ];
          };
        };
      };
  };
}
