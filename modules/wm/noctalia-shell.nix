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
  flake.homeModules.noctalia-shell = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        audio = {
          enable_sounds = true;
        };
        bar = {
          default = {
            background_opacity = 0.8;
            capsule = true;
            capsule_border = "outline";
            font_family = "JetBrainsMono Nerd Font Mono";
            position = "top";
          };
        };
        desktop_widgets = {
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          schema_version = 2;
          widget = { };
          widget_order = [ ];
        };
        dock = {
          auto_hide = true;
          background_opacity = 0.7;
          enabled = true;
          launcher_position = "start";
          margin_edge = 0;
          pinned = [
            "firefox"
            "kitty"
            "equibop"
            "pcmanfm"
          ];
          position = "bottom";
          reserve_space = false;
        };
        hot_corners = {
          enabled = true;
        };
        idle = {
          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 600;
            };
            lock-and-suspend = {
              action = "lock_and_suspend";
              enabled = true;
              timeout = 900;
            };
            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 660;
            };
          };
          behavior_order = [
            "lock"
            "screen-off"
            "lock-and-suspend"
          ];
        };
        keybinds = {
          cancel = [ "escape" ];
          down = [
            "down"
            "ctrl+j"
          ];
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
          validate = [ "return" ];
        };
        location = {
          auto_locate = true;
          custom_schedule = true;
          sunrise = "06:30";
          sunset = "17:30";
        };
        lockscreen = {
          enabled = true;
          wallpaper = "/home/krish/Pictures/Wallpapers/Gruvbox/camera.png";
        };
        lockscreen_widgets = {
          enabled = true;
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
            lockscreen-widget-0000000000000001 = {
              box_height = 0;
              box_width = 0;
              cx = 960;
              cy = 108;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background_opacity = 0.47;
                background_padding = 14;
                background_radius = 20;
                clock_style = "digital";
                format = "{:%I:%M %p}";
              };
              type = "clock";
            };
            lockscreen-widget-0000000000000002 = {
              box_height = 352;
              box_width = 544;
              cx = 960;
              cy = 540;
              output = "eDP-1";
              rotation = -0;
              settings = {
                background = false;
                background_color = "surface";
                background_opacity = 0.8;
                background_padding = 10;
                background_radius = 12;
                bar_width = 0.6;
                bloom_intensity = 0.5;
                fade_when_idle = true;
                inner_diameter = 0.7;
                primary_color = "primary";
                ring_opacity = 0.8;
                rotation_speed = 0.5;
                secondary_color = "secondary";
                sensitivity = 1.5;
                visualization_mode = "all";
                wave_thickness = 1;
              };
              type = "fancy_audio_visualizer";
            };
            lockscreen-widget-0000000000000003 = {
              box_height = 192;
              box_width = 224;
              cx = 160;
              cy = 124;
              output = "eDP-1";
              rotation = 0;
              settings = {
                background = false;
                background_opacity = 0.5;
                background_radius = 32;
                image_path = "/home/krish/Pictures/Wallpapers/Fastfetch/Shinchan.png";
                opacity = 1;
              };
              type = "sticker";
            };
          };
          widget_order = [
            "lockscreen-login-box@eDP-1"
            "lockscreen-widget-0000000000000001"
            "lockscreen-widget-0000000000000002"
            "lockscreen-widget-0000000000000003"
          ];
        };
        nightlight = {
          enabled = true;
        };
        osd = {
          background_opacity = 0.97;
        };
        shell = {
          animation = {
            enabled = true;
          };
          avatar_path = "/home/krish/.face";
          clipboard_enabled = true;
          corner_radius_scale = 2;
          font_family = "monospace";
          launch_apps_as_systemd_services = true;
          niri_overview_type_to_launch_enabled = true;
          offline_mode = true;
          panel = {
            transparency_mode = "glass";
          };
          password_style = "random";
          polkit_agent = true;
          screen_time_enabled = true;
          telemetry_enabled = false;
          time_format = "{:%-I:%M %p}";
        };
        theme = {
          builtin = "Gruvbox";
          community_palette = "Gruvbox Material";
          custom_palette = "Gruvbox Material Dark Hard";
          mode = "dark";
          source = "custom";
        };
        wallpaper = {
          default = {
            path = "/home/krish/Pictures/Wallpapers/Gruvbox/camera-2.jpg";
          };
          enabled = true;
          last = {
            path = "/home/krish/Pictures/Wallpapers/Gruvbox/camera-2.jpg";
          };
          monitors = {
            eDP-1 = {
              path = "/home/krish/Pictures/Wallpapers/Gruvbox/camera-2.jpg";
            };
          };
        };
        widget = {
          clock = {
            format = "{:%d-%m-%Y %-I:%M %p}";
          };
          media = {
            album_art_only = false;
            hide_when_no_media = true;
            max_length = 150;
          };
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
