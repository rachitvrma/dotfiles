# WARN: Don't delete this file at all.

# Just delete the block
{ shinchan, pkgs, ... }:
{
  bar = {
    default = {
      background_opacity = 0.8;
      capsule = true;
      capsule_group = [
        {
          accordion = true;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g1";
          members = [
            "network"
            "bluetooth"
          ];
          opacity = 0.9;
          padding = 6;
          widget_spacing = 10;
        }
        {
          accordion = true;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g2";
          members = [
            "volume"
            "brightness"
          ];
          opacity = 0.9;
          padding = 6;
          widget_spacing = 10;
        }
        {
          accordion = true;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g3";
          members = [
            "control-center"
            "caffeine"
            "nightlight"
            "launcher"
            "wallpaper"
          ];
          opacity = 0.9;
          padding = 6;
          widget_spacing = 10;
        }
        {
          accordion = true;
          accordion_direction = "start";
          enabled = true;
          fill = "surface_variant";
          id = "g4";
          members = [
            "audio_visualizer"
            "media"
          ];
          opacity = 0.9;
          padding = 6;
          widget_spacing = 10;
        }
        {
          accordion = false;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g5";
          members = [
            "battery"
            "power_profile"
          ];
          opacity = 0.9;
          padding = 6;
        }
        {
          accordion = true;
          accordion_direction = "end";
          enabled = true;
          fill = "surface_variant";
          id = "g6";
          members = [
            "cpu"
            "ram"
            "temp"
          ];
          opacity = 0.9;
          padding = 6;
        }
      ];
      capsule_opacity = 0.9;
      center = [
        "pomodoro"
        "clock-12h"
      ];
      end = [
        "group:g6"
        "group:g4"
        "tray"
        "notifications"
        "group:g1"
        "group:g2"
        "group:g5"
        "session"
      ];
      # font_family = "Maple Mono NF";
      margin_ends = 50;
      panel_overlap = 0;
      radius = 80;
      start = [
        "group:g3"
        "workspaces"
      ];
    };
    order = [ "main" ];
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
    # background_opacity = 0.7;
    enabled = true;
    icon_size = 40;
    item_spacing = 10;
    launcher_custom_image = "/home/krish/.face";
    launcher_position = "start";
    margin_edge = 0;
    margin_ends = 10;
    pinned = [
      "firefox"
      "pcmanfm"
      "kitty"
    ];
    radius = 80;
    reserve_space = false;
    smart_auto_hide = true;
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
    down = [
      "Down"
      "Ctrl+n"
    ];
    left = [
      "Left"
      "Ctrl+h"
    ];
    right = [
      "Right"
      "Ctrl+f"
    ];
    up = [
      "Up"
      "Ctrl+p"
    ];
    cancel = [
      "Escape"
      "Ctrl+g"
    ];
  };
  location = {
    auto_locate = true;
  };
  lockscreen_widgets = {
    enabled = true;
    grid = {
      cell_size = 8;
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
        placement_height = 0;
        placement_width = 0;
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
        box_width = 810;
        cx = 960;
        cy = 926;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background_color = "surface_variant";
          background_opacity = 0.88;
          background_radius = 32;
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
        box_height = 200;
        box_width = 424;
        cx = 960;
        cy = 240;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = -0;
        settings = {
          background_color = "surface_variant";
          background_opacity = 0.62;
          background_padding = 32;
          background_radius = 32;
          clock_style = "digital";
          color = "on_surface";
          format = "{:%I:%M:%S %p}\\n{:%a, %b %d}";
        };
        type = "clock";
      };
      lockscreen-widget-0000000000000002 = {
        box_height = 352;
        box_width = 544;
        cx = 960;
        cy = 540;
        output = "eDP-1";
        rotation = 0;
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
        box_height = 160;
        box_width = 256;
        cx = 1728;
        cy = 148;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background = false;
          background_opacity = 0.5;
          background_radius = 32;
          image_path = shinchan pkgs;
          opacity = 1;
        };
        type = "sticker";
      };
      lockscreen-widget-0000000000000004 = {
        box_height = 400;
        box_width = 496;
        cx = 1648;
        cy = 252;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background = true;
          background_color = "surface";
          background_opacity = 0.8;
          background_padding = 10;
          background_radius = 12;
          font_family = "";
          show_events = true;
          show_week_numbers = false;
        };
        type = "calendar";
      };
      lockscreen-widget-0000000000000005 = {
        box_height = 0;
        box_width = 0;
        cx = 116;
        cy = 83;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background_radius = 32;
          stat = "cpu_usage";
          stat2 = "cpu_temp";
        };
        type = "sysmon";
      };
      lockscreen-widget-0000000000000006 = {
        box_height = 224;
        box_width = 672;
        cx = 968;
        cy = 564;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          hide_when_no_media = true;
          layout = "horizontal";
        };
        type = "media_player";
      };
      lockscreen-widget-0000000000000007 = {
        box_height = 432;
        box_width = 544;
        cx = 1728;
        cy = 164;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background = false;
          background_color = "surface";
          background_opacity = 0.8;
          background_padding = 10;
          background_radius = 12;
          bar_width = 0.8;
          bloom_intensity = 0.5;
          fade_when_idle = true;
          inner_diameter = 1;
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
      lockscreen-widget-0000000000000008 = {
        box_height = 184;
        box_width = 400;
        cx = 1664;
        cy = 904;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background_radius = 32;
          layout = "horizontal";
        };
        type = "media_player";
      };
      lockscreen-widget-0000000000000009 = {
        box_height = 144;
        box_width = 800;
        cx = 960;
        cy = 684;
        output = "eDP-1";
        placement_height = 1080;
        placement_width = 1920;
        rotation = 0;
        settings = {
          background_opacity = 0;
          background_padding = 0;
          background_radius = 32;
          bands = 128;
          centered = false;
          color_2 = "secondary";
          mirrored = true;
          reversed = true;
          show_when_idle = false;
        };
        type = "audio_visualizer";
      };
    };
    widget_order = [
      "lockscreen-widget-0000000000000009"
      "lockscreen-widget-0000000000000007"
      "lockscreen-login-box@HDMI-A-1"
      "lockscreen-login-box@eDP-1"
      "lockscreen-widget-0000000000000001"
      "lockscreen-widget-0000000000000005"
      "lockscreen-widget-0000000000000003"
      "lockscreen-widget-0000000000000008"
    ];
  };
  nightlight = {
    enabled = true;
  };
  notification = {
    background_opacity = 0.8;
  };
  osd = {
    background_opacity = 0.8;
  };
  plugin_settings = {
    "thepunkoff/pomodoro" = {
      auto-start-breaks = true;
      auto-start-work = true;
      page-open-near-click = false;
      use-bundled-alarm-sound = true;
    };
  };
  plugins = {
    auto_update = "all";
    enabled = [
      "thepunkoff/pomodoro"
      "noctalia/kaomoji"
    ];
    source = [
      {
        enabled = true;
        kind = "git";
        location = "https://github.com/noctalia-dev/official-plugins";
        name = "official";
      }
      {
        enabled = true;
        kind = "git";
        location = "https://github.com/noctalia-dev/community-plugins";
        name = "community";
      }
    ];
  };
  shell = {
    avatar_path = "~/.face";
    corner_radius_scale = 2;
    # font_family = "Maple Mono NF";
    greeter_sync = {
      auto_sync = true;
    };
    launch_apps_as_systemd_services = true;
    niri_overview_type_to_launch_enabled = true;
    offline_mode = false;
    panel = {
      transparency_mode = "glass";
    };
    password_style = "random";
    polkit_agent = true;
    settings_window_translucent = false;
    time_format = "{:%-I:%M %p}";
  };
  audio = {
    enable_sounds = true;
  };
  theme = {
    builtin = "Gruvbox";
    community_palette = "Catppuccin Mocha Mauve-Lavender";
    custom_palette = "stylix";
    mode = "dark";
    source = "custom";
    wallpaper_scheme = "m3-content";
  };
  wallpaper = {
    default = {
      path = "/home/krish/Pictures/Wallpapers/Tokyonight/wallhaven-5ym138_1920x1080.png";
    };
    last = {
      path = "/home/krish/Pictures/Wallpapers/Tokyonight/wallhaven-5ym138_1920x1080.png";
    };
    monitors = {
      eDP-1 = {
        path = "/home/krish/Pictures/Wallpapers/Tokyonight/wallhaven-5ym138_1920x1080.png";
      };
    };
  };
  widget = {
    audio_visualizer = {
      bands = 20;
      centered = true;
      color_2 = "secondary";
      show_when_idle = false;
      width = 64;
    };
    clock-12h = {
      format = "{:%-I:%M:%S %p}";
      type = "clock";
    };
    cpu = {
      label_min_width = 10;
      visualization = "graph";
    };
    media = {
      album_art_only = true;
      hide_when_no_media = true;
    };
    pomodoro = {
      type = "thepunkoff/pomodoro:widget";
    };
    ram = {
      visualization = "graph";
    };
    sysmon = {
      visualization = "graph";
    };
    temp = {
      visualization = "graph";
    };
    tray = {
      detached_panel = false;
      drawer = true;
      drawer_columns = 3;
      drawer_item_size = 20;
    };
    workspaces = {
      active_pill_size = 3.45;
      hide_when_empty = true;
      inactive_pill_size = 1.6;
      label_source = "name";
      pill_scale = 0.6;
      show_labels = false;
    };
  };
}
