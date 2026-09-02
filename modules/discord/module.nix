{
  flake.homeModules.discord =
    {
      config,
      ...
    }:
    {
      xdg.autostart.entries = [ "${config.programs.equibop.package}/share/applications/equibop.desktop" ];
      programs.equibop = {
        enable = true;
        settings = {
          appBadge = true;
          arRPC = true;
          autoStartMinimized = true;
          badgeOnlyForMentions = true;
          checkUpdates = false;
          clickTrayToShowHide = true;
          customTitleBar = true;
          disableMinSize = true;
          discordBranch = "stable";
          enableTaskbarFlashing = true;
          hardwareAcceleration = true;
          hardwareVideoAcceleration = true;
          minimizeToTray = true;
          splashBackground = "rgb(18, 18, 20)";
          splashColor = "color(srgb 0.984314 0.984314 0.984314)";
          splashProgress = true;
          splashTheming = true;
          staticTitle = true;
          tray = true;
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
