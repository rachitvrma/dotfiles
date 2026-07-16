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
            font_family = config.gtk.font.name;
            position = "bottom";
            background_opacity = 0.97;
          };
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
            launcher_session_search = true;
            transparency_mode = "glass";
          };
        };
        hot_corners.enabled = true;
        theme = {
          builtin = "Gruvbox";
        };
        wallpaper = {
          default = {
            path = "/home/krish/Pictures/Wallpapers/Gruvbox/castle.jpg";
          };
          enable = true;
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
          position = "bottom_center";
          background_opacity = 0.97;
        };

        dock = {
          enabled = true;
          position = "top";
          auto_hide = true;
          reserve_space = false;
          pinned = [
            "firefox"
            "kitty"
          ];
        };
        keybinds = {
          validate = [
            "return"
            "kp_return"
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
  };
}
