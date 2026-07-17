{ inputs, ... }: {
  flake.nixosModules.noctalia-shell = { pkgs, ... }: {
    imports = [ inputs.noctalia.nixosModules.default ];
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
  };
  flake.homeModules.noctalia-shell = { config, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        audio.enable_sounds = true;
        nightlight.enabled = true;
        bar = {
          default = {
            capsule = true;
            capsule_border = "outline";
            font_family = config.gtk.font.name;
            position = "top";
            background_opacity = 0.8;
          };
        };
        lockscreen = {
          enabled = true;
          wallpaper = "/home/krish/Pictures/Wallpapers/Gruvbox/117497448_p0.jpg";
        };
        lockscreen_widgets = {
          enabled = false;
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          schema_version = 2;
          widget = {
            "lockscreen-login-box@eDP-1" = {
              box_height = 70;
              box_width = 400;
              cx = 960;
              cy = 961;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12;
                center_password_text = true;
                input_opacity = 1;
                input_radius = 6;
                show_caps_lock = true;
                show_keyboard_layout = true;
                show_login_button = true;
                show_password_hint = true;
              };
              type = "login_box";
            };
          };
          widget_order = [ "lockscreen-login-box@eDP-1" ];
        };
        widget.clock = {
          format = "{:%-I:%M %p}";
        };
        shell = {
          avatar_path = "/home/krish/.face";
          launch_apps_as_systemd_services = true;
          font_family = "monospace";
          corner_radius_scale = 2;
          password_style = "random";
          niri_overview_type_to_launch_enabled = true;
          offline_mode = true;
          telemetry_enabled = false;
          polkit_agent = true;
          screen_time_enabled = true;
          clipboard_enabled = true;
          animation.enabled = true;
          time_format = "{:%-I:%M %p}";

          panel = {
            transparency_mode = "glass";
          };
        };
        hot_corners.enabled = true;
        theme = {
          mode = "dark";
          source = "custom";
          builtin = "Gruvbox";
          community_palette = "Gruvbox Material";
          custom_palette = "Gruvbox Material Dark Hard";
        };
        wallpaper = {
          default = {
            path = "/home/krish/Pictures/Wallpapers/Gruvbox/castle.jpg";
          };
          enabled = true;
          last = {
            path = "/home/krish/Pictures/Wallpapers/Gruvbox/castle.jpg";
          };
          monitors = {
            eDP-1 = {
              path = "/home/krish/Pictures/Wallpapers/Gruvbox/castle.jpg";
            };
          };
        };

        osd = {
          # position = "bottom_center";
          background_opacity = 0.97;
        };

        dock = {
          enabled = true;
          position = "bottom";
          auto_hide = true;
          reserve_space = false;
          launcher_position = "start";
          pinned = [
            "firefox"
            "kitty"
            "equibop"
            "pcmanfm"
          ];
          background_opacity = 0.7;
          margin_edge = 0;
        };
        keybinds = {
          validate = [
            "return"
          ];
          cancel = [ "escape" ];
          left = [
            "left"
            "ctrl+h"
          ];
          right = [
            "right"
            "ctrl+l"
          ];
          up = [
            "up"
            "ctrl+k"
          ];
          down = [
            "down"
            "ctrl+j"
          ];
        };
      };
    };

    xdg.configFile."noctalia/palettes/Gruvbox Material Dark Hard.json".text = builtins.toJSON {
      dark = {
        mError = "#ea6962";
        mHover = "#89b482";
        mOnError = "#141617";
        mOnHover = "#141617";
        mOnPrimary = "#141617";
        mOnSecondary = "#141617";
        mOnSurface = "#ddc7a1";
        mOnSurfaceVariant = "#bdae93";
        mOnTertiary = "#141617";
        mOutline = "#5a524c";
        mPrimary = "#d3869b";
        mSecondary = "#7daea3";
        mShadow = "#141617";
        mSurface = "#141617";
        mSurfaceVariant = "#1d2021";
        mTertiary = "#89b482";
        terminal = {
          background = "#141617";
          bright = {
            black = "#5a524c";
            blue = "#7daea3";
            cyan = "#89b482";
            green = "#a9b665";
            magenta = "#d3869b";
            red = "#ea6962";
            white = "#ebdbb2";
            yellow = "#d8a657";
          };
          cursor = "#ddc7a1";
          cursorText = "#141617";
          foreground = "#ddc7a1";
          normal = {
            black = "#1d2021";
            blue = "#7daea3";
            cyan = "#89b482";
            green = "#a9b665";
            magenta = "#d3869b";
            red = "#ea6962";
            white = "#ddc7a1";
            yellow = "#d8a657";
          };
          selectionBg = "#5a524c";
          selectionFg = "#ddc7a1";
        };
      };
      light = {
        mError = "#cc241d";
        mHover = "#427b58";
        mOnError = "#fbf1c7";
        mOnHover = "#fbf1c7";
        mOnPrimary = "#fbf1c7";
        mOnSecondary = "#fbf1c7";
        mOnSurface = "#3c3836";
        mOnSurfaceVariant = "#7c6f64";
        mOnTertiary = "#fbf1c7";
        mOutline = "#bdae93";
        mPrimary = "#b16286";
        mSecondary = "#458588";
        mShadow = "#d5c4a1";
        mSurface = "#fbf1c7";
        mSurfaceVariant = "#f2e5bc";
        mTertiary = "#427b58";
        terminal = {
          background = "#fbf1c7";
          bright = {
            black = "#928374";
            blue = "#076678";
            cyan = "#427b58";
            green = "#79740e";
            magenta = "#8f3f71";
            red = "#9d0006";
            white = "#3c3836";
            yellow = "#b57614";
          };
          cursor = "#3c3836";
          cursorText = "#fbf1c7";
          foreground = "#3c3836";
          normal = {
            black = "#fbf1c7";
            blue = "#458588";
            cyan = "#689d6a";
            green = "#98971a";
            magenta = "#b16286";
            red = "#cc241d";
            white = "#7c6f64";
            yellow = "#d79921";
          };
          selectionBg = "#3c3836";
          selectionFg = "#fbf1c7";
        };
      };
    };
  };
}
