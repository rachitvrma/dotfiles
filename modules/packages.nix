{ self, ... }:
{
  flake.nixosModules.packages = { pkgs, ... }: {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
    ];

    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
    };

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    security = {
      sudo = {
        enable = true;
        execWheelOnly = true;
        package = pkgs.sudo.override {
          withInsults = true;
        };

        extraConfig =
          # bash
          ''
            Defaults pwfeedback
          '';
      };
    };
  };

  flake.homeModules.packages = { pkgs, config, ... }: {
    # Autostart equibop
    xdg.autostart.entries = [ "${config.programs.equibop.package}/share/applications/equibop.desktop" ];
    programs = {
      # For autostart, I use xdg.autostart.entries module
      equibop = {
        enable = true;
        settings = {
          appBadge = false;
          arRPC = true;
          checkUpdates = false;
          customTitleBar = false;
          disableMinSize = true;
          minimizeToTray = false;
          tray = false;
          splashBackground = "#000000";
          splashColor = "#ffffff";
          splashTheming = true;
          staticTitle = true;
          hardwareAcceleration = true;
          discordBranch = "stable";
        };
        equicord = {
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
            };
            useQuickCss = true;
          };
        };
      };
      pandoc.enable = true;
      atool = {
        enable = true;
        extraPackages = with pkgs; [
          bzip2
          cpio
          gnutar
          gzip
          lhasa
          lzop
          p7zip
          unrar-free
          unzip
          xz
          zip
        ];
        settings = {
          path_unrar = "unrar-free";
        };
      };
      btop = {
        enable = true;
        package = pkgs.symlinkJoin {
          name = "btop-wrapped";
          paths = [ pkgs.btop ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/btop \
            --add-flags "--force-utf"
          '';
        };
      };
      bottom = {
        enable = true;
      };
      gcc.enable = true;
      # TODO: Make a module for $XDG_CONFIG_HOME/cava/themes
      # NOTE: For cava enabled the stylix.cava.rainbow.enable
      cava = {
        enable = true;
        settings = {
          general = {
            live-config = 1;
            framerate = 60;
            sensitivity = 100;
            lower_cutoff_freq = 50;
            higher_cutoff_freq = 1000;
          };
          input = {
            method = "pipewire";
          };
          smoothing = {
            monstercat = 1;
            waves = 1;
            noise_reduction = 77;
          };
        };
      };

      onlyoffice = {
        enable = true;
        settings = {
          UITheme = "theme-dark";
          titlebar = "custom";
          maximized = true;
          editorWindowMode = false;
          forcedRtl = false;
        };
      };
    };

    home.packages = with pkgs; [
      gitingest
      wl-clipboard
      unzip
      gophertube
      kotatogram-desktop
    ];
  };
}
