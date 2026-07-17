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

  flake.homeModules.packages = { pkgs, ... }: {
    programs = {
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
      bottom = {
        enable = true;
        settings = {
          styles = {
            battery = {
              high_battery_colour = "#a9b665";
              low_battery_colour = "#ea6962";
              medium_battery_colour = "#d8a657";
            };
            cpu = {
              all_entry_colour = "#ddc7a1";
              avg_entry_colour = "#d3869b";
              cpu_core_colours = [
                "#ea6962"
                "#e78a4e"
                "#d8a657"
                "#a9b665"
                "#89b482"
                "#7daea3"
                "#d3869b"
                "#bd6f3e"
              ];
            };
            graphs = {
              graph_colour = "#5a524c";
              legend_text = {
                colour = "#ebdbb2";
              };
            };
            memory = {
              arc_colour = "#89b482";
              cache_colour = "#7daea3";
              gpu_colours = [
                "#d3869b"
                "#d8a657"
                "#7daea3"
              ];
              ram_colour = "#a9b665";
              swap_colour = "#e78a4e";
            };
            network = {
              rx_colour = "#a9b665";
              rx_total_colour = "#bdae93";
              tx_colour = "#d3869b";
              tx_total_colour = "#ebdbb2";
            };
            tables = {
              headers = {
                bold = true;
                colour = "#7daea3";
              };
            };
            temp_graph = {
              temp_graph_colour_styles = [
                "#a9b665"
                "#89b482"
                "#d8a657"
                "#e78a4e"
                "#ea6962"
              ];
            };
            widgets = {
              bg_colour = "#141617";
              border_colour = "#5a524c";
              disabled_text = {
                colour = "#5a524c";
              };
              selected_border_colour = "#d3869b";
              selected_text = {
                bg_colour = "#d3869b";
                bold = true;
                colour = "#141617";
              };
              text = {
                colour = "#ddc7a1";
              };
              thread_text = {
                colour = "#89b482";
              };
              widget_title = {
                bold = true;
                colour = "#d3869b";
              };
            };
          };
        };
      };
      gcc.enable = true;
      # TODO: Make a module for $XDG_CONFIG_HOME/cava/themes
      cava = {
        enable = true;
        settings = {
          general = {
            live-config = 1;
          };
          input = {
            method = "pipewire";
          };
          smoothing = {
            monstercat = 1;
            waves = 1;
            noise_reduction = 77;
          };
          color = {
            background = "'#141617'";
            foreground = "'#ddc7a1'";
            gradient = 1;
            gradient_color_1 = "'#ea6962'";
            gradient_color_2 = "'#e78a4e'";
            gradient_color_3 = "'#d8a657'";
            horizontal_gradient = 1;
            horizontal_gradient_color_1 = "'#a9b665'";
            horizontal_gradient_color_2 = "'#7daea3'";
            horizontal_gradient_color_3 = "'#d3869b'";
            blend_direction = "up";
          };
        };
      };
    };

    home.packages = with pkgs; [
      gitingest
      wl-clipboard
      unzip
      gophertube
      weechat
    ];
  };
}
