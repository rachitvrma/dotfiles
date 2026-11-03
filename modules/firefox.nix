{
  flake.nixosModules.firefox =
    { lib, pkgs, ... }:

    {
      programs.firefox = {
        enable = true;

        languagePacks = [ "en-US" ];

        # Written to autoconfig, so applies to every profile on the system.
        # "default" lets you still change these from the UI / about:config.
        preferencesStatus = "default";
        preferences = {
          # Allow userChrome.css and userContent.css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          # Vertical tabs, on the right, auto-collapsing
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
          "sidebar.position_start" = false; # false = right side
          "sidebar.visibility" = "expand-on-hover"; # collapsed until hovered
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        };

        policies = {
          # Updates & Background Services
          AppAutoUpdate = false;
          BackgroundAppUpdate = false;

          # Feature Disabling
          DisableBuiltinPDFViewer = true;
          DisableFirefoxStudies = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxScreenshots = true;
          DisableForgetButton = true;
          DisableMasterPasswordCreation = true;
          DisableProfileImport = true;
          DisableProfileRefresh = true;
          DisableSetDesktopBackground = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFormHistory = true;
          DisablePasswordReveal = true;

          # Access Restrictions
          BlockAboutConfig = false;
          BlockAboutProfiles = true;
          BlockAboutSupport = true;

          # UI and Behavior
          DisplayMenuBar = "never";
          DontCheckDefaultBrowser = true;
          HardwareAcceleration = false;
          OfferToSaveLogins = false;
          # Escaped on purpose: Firefox expands ${home} itself at runtime
          DefaultDownloadDirectory = "\${home}/Downloads";

          # Search engines (replaces profiles.default.search)
          SearchEngines = {
            Default = "DuckDuckGo";
            Add = [
              {
                Name = "Nix Packages";
                URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                Method = "GET";
                IconURL = "https://nixos.org/favicon.svg";
                Alias = "@np";
              }
              {
                Name = "Nix Options";
                URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
                Method = "GET";
                IconURL = "https://nixos.org/favicon.svg";
                Alias = "@no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                Method = "GET";
                IconURL = "https://nixos.org/favicon.svg";
                Alias = "@nw";
              }
            ];
          };

          # Extensions
          ExtensionSettings =
            let
              moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
            in
            {
              "*".installation_mode = "blocked";

              "uBlock0@raymondhill.net" = {
                install_url = moz "ublock-origin";
                installation_mode = "force_installed";
                updates_disabled = true;
              };
            };

          # Extension configuration
          "3rdparty".Extensions = {
            "uBlock0@raymondhill.net".adminSettings = {
              userSettings = rec {
                uiTheme = "dark";
                uiAccentCustom = true;
                uiAccentCustom0 = "#f5c2e7";
                cloudStorageEnabled = lib.mkForce false;

                importedLists = [
                  "https://filters.adtidy.org/extension/ublock/filters/3.txt"
                  "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                ];

                externalLists = lib.concatStringsSep "\n" importedLists;
              };

              selectedFilterLists = [
                "CZE-0"
                "adguard-generic"
                "adguard-annoyance"
                "adguard-social"
                "adguard-spyware-url"
                "easylist"
                "easyprivacy"
                "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
                "plowe-0"
                "ublock-abuse"
                "ublock-badware"
                "ublock-filters"
                "ublock-privacy"
                "ublock-quick-fixes"
                "ublock-unbreak"
                "urlhaus-1"
              ];
            };
          };
        };
      };
    };
}
