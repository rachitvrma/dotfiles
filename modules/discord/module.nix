{
  flake.homeModules.discord =
    { config, ... }:
    {
      xdg.autostart.entries = [ "${config.programs.vesktop.package}/share/applications/vesktop.desktop" ];
      programs.vesktop = {
        enable = true;
        settings = {
          appBadge = true;
          arRPC = true;
          autoStartMinimized = true;
          badgeOnlyForMentions = true;
          checkUpdates = false;
          clickTrayToShowHide = true;
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
          staticTitle = false;
          tray = true;
          customTitleBar = false;
          enableMenu = false;
        };
        vencord = {
          useSystem = true;
          settings = {
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
              AlwaysAnimate.enabled = true;
              AlwaysTrust.enabled = true;
              oneko.enabled = true;
            };
            useQuickCss = true;

            cloud = {
              authenticated = false;
              settingsSync = false;
              settingsSyncVersion = 1788428016902;
              url = "https://api.vencord.dev/";
            };
            eagerPatches = false;
            enableReactDevtools = false;
            frameless = true;
            notifications = {
              logLimit = 50;
              position = "bottom-right";
              timeout = 5000;
              useNative = "not-focused";
            };
            themeLinks = [ ];
            transparent = true;
            uiElements = {
              chatBarButtons = { };
              messagePopoverButtons = { };
            };
            winCtrlQ = false;
            winNativeTitleBar = false;
            windowsMaterial = "none";
          };
        };
      };
    };
}
