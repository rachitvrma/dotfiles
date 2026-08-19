{
  flake.homeModules.discord = { config, ... }: {
    xdg.autostart.entries = [ "${config.programs.equibop.package}/share/applications/equibop.desktop" ];
    programs.equibop = {
      enable = true;
      settings = {
        appBadge = false;
        arRPC = true;
        checkUpdates = false;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = false;
        tray = false;
        splashBackground = "#1e1e2e";
        splashColor = "#f5e0dc";
        splashTheming = true;
        staticTitle = true;
        hardwareAcceleration = true;
        discordBranch = "stable";
      };
      equicord = {
        themes = {
          catppuccin-clearvision = builtins.readFile ./catppuccin-ClearVision-v7-BetterDiscord.theme.css;
        };
        settings = {
          enabledThemes = [ "catppuccin-clearvision.css" ];
          autoUpdate = false;
          autoUpdateNotification = false;
          disableMinSize = true;
          notifyAboutUpdates = false;
          plugins = {
            FakeNitro = {
              enabled = true;
            };
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
          };
          useQuickCss = true;
        };
      };
    };
  };
}
