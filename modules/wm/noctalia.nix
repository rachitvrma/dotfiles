{
  flake.nixosModules.noctalia = {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true;
    };
  };

  # For modification see noctalia module in experimental modules
  flake.homeModules.noctalia = { config, ... }: {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        audio = {
          enable_sounds = true;
        };
        bar = {
          default = {
            background_opacity = config.stylix.opacity.desktop;
            capsule = true;
            capsule_border = "outline";

            capsule_opacity = 0.89999997988343239;
            position = "top";
          };
        };
        battery.warning_threshold = 55;
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
          wallpaper = "/home/krish/Pictures/Wallpapers/Catppuccin/wallhaven-k8d7j7_1920x1080.png";
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
                background_radius = 12;
                center_password_text = true;
                input_opacity = 1;
                input_radius = 6;
                show_caps_lock = true;
                show_keyboard_layout = true;
                show_login_button = true;
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
        };
        shell = {
          animation = {
            enabled = true;
          };
          avatar_path = "/home/krish/.face";
          clipboard_enabled = true;
          corner_radius_scale = 2;
          # font_family = "monospace";
          launch_apps_as_systemd_services = true;
          niri_overview_type_to_launch_enabled = true;
          offline_mode = false;
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
          builtin = "Catppuccin";
          community_palette = "Catppuccin Mocha Mauve-Lavender";
          mode = "dark";
          source = "custom";
        };
        wallpaper = {
          enabled = true;
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
        notification = {
          enable_daemon = true;
          layer = "overlay";
        };
      };
    };
  };
}
