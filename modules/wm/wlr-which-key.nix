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
              key = "c";
              desc = "clipboard";
              cmd = "noctalia msg panel-toggle clipboard";
            }
            {
              key = "e";
              desc = "Equibop";
              cmd = "systemd-run --user equibop";
            }
          ];
        };

        extraMenus = {
          browsers = commonSettings // {
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
        };
      };
  };
}
