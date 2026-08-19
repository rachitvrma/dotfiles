{
  flake.nixosModules.noctalia = { pkgs, ... }: {
    programs = {
      noctalia = {
        enable = true;
        systemd.enable = true;
        recommendedServices.enable = true;
      };
    };
    services.displayManager.noctalia-greeter = {
      enable = true;
      cursorTheme = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
      };
      settings = {
        session.default = "niri";
        user.default = "krish";
        appearance = {
          scheme = "Synced";
          password_style = "random";
          hide_logo = false;
          theme_mode = "dark";
          corner_radius_scale = 2.0;
        };
        keyboard = {
          layout = "us";
          variant = "colemak_dh";
          options = "caps:swapescape";
          numlock = true;
        };
        auth = {
          allow_empty_password = false;
        };
      };
    };

    # For Avatar Image
    systemd.tmpfiles.rules =
      let
        shinchan = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Fastfetch/Shinchan.png";
          hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
        };
      in
      [
        "L+ /var/lib/AccountsService/icons/krish - - - - ${shinchan}"
        "f+ /var/lib/AccountsService/users/krish 0644 root root - [User]\\nIcon=/var/lib/AccountsService/icons/krish\\n"
      ];
  };

  # For modification see noctalia module in experimental modules
  flake.homeModules.noctalia = { pkgs, ... }: {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings =
        let
          shinchan = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Fastfetch/Shinchan.png";
            hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
          };
        in
        {
          widget = {
            clock-12h = {
              type = "clock";
              format = "{:%-I:%M:%S %p}";
            };
            audio_visualizer = {
              width = 64;
              bands = 20;
              centered = true;
              show_when_idle = true;
              color_2 = "secondary";
            };
            tray = {
              drawer = true;
              drawer_columns = 3;
              drawer_item_size = 20;
              detached_panel = false;
            };
          };
          nightlight.enabled = true;
          bar = {
            order = [ "main" ];
            default = {
              background_opacity = 0.8;
              capsule = true;
              capsule_opacity = 0.9;

              start = [
                "group:g3"
                "workspaces"
              ];
              center = [ "clock-12h" ];
              end = [
                "group:g4"
                "tray"
                "notifications"
                "group:g1"
                "group:g2"
                "battery"
                "session"
              ];

              capsule_group = [
                # Wireless stuff
                {
                  id = "g1";
                  members = [
                    "network"
                    "bluetooth"
                  ];
                  fill = "surface_variant";
                  padding = 6.0;
                  opacity = 0.9;
                  enabled = true;
                  accordion = true;
                  accordion_direction = "end";
                  widget_spacing = 10;
                }
                # Volume and brightness can go together
                {
                  id = "g2";
                  members = [
                    "volume"
                    "brightness"
                  ];
                  fill = "surface_variant";
                  padding = 6.0;
                  opacity = 0.9;
                  enabled = true;
                  accordion = true;
                  accordion_direction = "end";
                  widget_spacing = 10;
                }
                # Control-Center
                {
                  id = "g3";
                  members = [
                    "control-center"
                    "caffeine"
                    "nightlight"
                    "launcher"
                    "wallpaper"
                  ];
                  fill = "surface_variant";
                  padding = 6.0;
                  opacity = 0.9;
                  enabled = true;
                  accordion = true;
                  accordion_direction = "end";
                  widget_spacing = 10;
                }
                # Media and visualizer
                {
                  id = "g4";
                  members = [
                    "audio_visualizer"
                    "media"
                  ];
                  fill = "surface_variant";
                  padding = 6.0;
                  opacity = 0.9;
                  enabled = true;
                  widget_spacing = 10;
                  accordion_direction = "start";
                  accordion = true;
                }
              ];
            };
          };
          keybinds = {
            down = [
              "Down"
              "Ctrl+j"
            ];
            left = [
              "Left"
              "Ctrl+h"
            ];
            right = [
              "Right"
              "Ctrl+l"
            ];
            up = [
              "Up"
              "Ctrl+k"
            ];
          };
          battery = {
            warning_threshold = 60;
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
            enabled = true;
            launcher_position = "start";
            icon_size = 40;
            item_spacing = 10;
            launcher_custom_image = "/home/krish/.face";
            margin_edge = 10;
            margin_ends = 10;
            reserve_space = false;
            smart_auto_hide = true;
            pinned = [
              "firefox"
              "pcmanfm"
              "kitty"
            ];
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
          location = {
            auto_locate = true;
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
              "lockscreen-login-box@HDMI-A-1" = {
                box_height = 196;
                box_width = 810;
                cx = 683;
                cy = 577.5;
                output = "HDMI-A-1";
                rotation = 0;
                settings = {
                  background_color = "surface_variant";
                  background_opacity = 0.88;
                  background_radius = 12;
                  center_password_text = false;
                  input_opacity = 1;
                  input_radius = 6;
                  layout = "regular";
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_media = true;
                  show_session_buttons = true;
                  show_unlock_hint = true;
                  show_weather = true;
                };
                type = "login_box";
              };
              "lockscreen-login-box@eDP-1" = {
                box_height = 196;
                box_width = 720;
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
                  layout = "regular";
                  show_caps_lock = true;
                  show_keyboard_layout = true;
                  show_login_button = true;
                  show_media = true;
                  show_session_buttons = true;
                  show_unlock_hint = true;
                  show_weather = true;
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
                  image_path = shinchan;
                  opacity = 1;
                };
                type = "sticker";
              };
            };
            widget_order = [
              "lockscreen-login-box@HDMI-A-1"
              "lockscreen-login-box@eDP-1"
              "lockscreen-widget-0000000000000001"
              "lockscreen-widget-0000000000000002"
              "lockscreen-widget-0000000000000003"
            ];
          };
          notification = {
            background_opacity = 0.8;
          };
          osd = {
            background_opacity = 0.8;
          };
          shell = {
            avatar_path = "~/.face";
            corner_radius_scale = 2.0;
            font_family = "Maple Mono NF";
            launch_apps_as_systemd_services = true;
            niri_overview_type_to_launch_enabled = true;
            offline_mode = false;
            panel = {
              transparency_mode = "glass";
            };
            settings_window_translucent = false;
            polkit_agent = true;
            time_format = "{:%-I:%M %p}";
            greeter_sync = {
              auto_sync = true;
            };
          };
          theme = {
            builtin = "Gruvbox";
            community_palette = "Catppuccin Mocha Mauve-Lavender";
            custom_palette = "stylix";
            mode = "dark";
            source = "custom";
            wallpaper_scheme = "m3-content";
          };
        };
    };
  };
}
