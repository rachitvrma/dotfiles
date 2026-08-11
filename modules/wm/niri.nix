{
  flake.nixosModules.niri = { ... }: {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };
    services = {
      # The lid-switch events are handled by Niri and Noctalia
      logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
      };
      greetd = {
        enable = true;
        settings = rec {
          initial_session = {
            command = "niri-session";
            user = "krish";
          };
          default_session = initial_session;
        };
      };
    };
  };

  flake.homeModules.niri =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      xdg.portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
        ];
        configPackages = [ pkgs.niri ];
      };
      wayland.windowManager.niri = {
        enable = true;
        xwaylandSatellitePackage = pkgs.xwayland-satellite;
        systemd.enable = true;

        settings = {
          # ── environment.kdl + hm_config.kdl ──
          environment = {
            QT_QPA_PLATFORM = "wayland";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            GTK_THEME = config.gtk.theme.name;
            QS_ICON_THEME = config.stylix.icons.dark;
          };

          # ── cursor.kdl + hm_config.kdl ──
          cursor = {
            hide-when-typing = { };
            hide-after-inactive-ms = 6000;
            xcursor-theme = config.home.pointerCursor.name;
            xcursor-size = config.home.pointerCursor.size;
          };

          # ── input.kdl + hm_config.kdl (keyboard.xkb) ──
          input = {
            mouse.accel-profile = "flat";
            focus-follows-mouse._props.max-scroll-amount = "0%";
            keyboard = {
              repeat-delay = 250;
              repeat-rate = 35;
              track-layout = "global";
              numlock = { };
              xkb = {
                layout = config.home.keyboard.layout;
                variant = config.home.keyboard.variant;
                options = lib.concatStringsSep "," config.home.keyboard.options;
              };
            };
            touchpad = {
              dwt = { };
              dwtp = { };
              natural-scroll = { };
              tap = { };
              click-method = "clickfinger";
              scroll-factor = 0.7;
            };
            warp-mouse-to-focus = { };
            workspace-auto-back-and-forth = { };
          };

          # ── general.kdl ──
          clipboard.disable-primary = { };
          debug.honor-xdg-activation-with-invalid-serial = { };
          hotkey-overlay.skip-at-startup = { };
          overview = {
            backdrop-color = "#141617";
            # workspace-shadow was `{ // off }` (empty/disabled) in the source
            workspace-shadow = { };
          };
          switch-events.lid-close.spawn = [
            "noctalia"
            "msg"
            "session"
            "lock-and-suspend"
          ];
          prefer-no-csd = { };
          gestures.hot-corners.off = { };

          # ── blur.kdl ──
          blur = {
            passes = 2;
            offset = 4;
            noise = 0.00;
            saturation = 1.3;
          };

          # ── layout.kdl ──
          layout = {
            always-center-single-column = { };
            background-color = "transparent";
            default-column-width.proportion = 0.5000;
            empty-workspace-above-first = { };
            focus-ring.off = { };
            gaps = 5;
            preset-column-widths._children = [
              { proportion = 0.500000; }
              { proportion = 0.333333; }
              { proportion = 0.666667; }
            ];
            shadow = {
              draw-behind-window = false;
              offset._props = {
                x = 0;
                y = 2;
              };
              on = { };
              softness = 12;
              spread = 4;
              color = "#00000020";
            };
            tab-indicator = {
              corner-radius = 0.000000;
              gap = 5.000000;
              gaps-between-tabs = 10;
              length._props.total-proportion = 0.500000;
              position = "top";
              width = 4.000000;
            };
            border = {
              on = { };
              width = 2;
              urgent-color = config.lib.stylix.colors.withHashtag.base08;
              active-gradient._props = {
                from = config.lib.stylix.colors.withHashtag.base0E;
                to = config.lib.stylix.colors.withHashtag.base0D;
                angle = 45;
                relative-to = "workspace-view";
              };
              inactive-gradient._props = {
                from = config.lib.stylix.colors.withHashtag.base03;
                to = config.lib.stylix.colors.withHashtag.base04;
                angle = 45;
                relative-to = "workspace-view";
                "in" = "srgb-linear";
              };
            };
          };

          # ── recent-windows.kdl ──
          recent-windows = {
            debounce-ms = 750;
            open-delay-ms = 150;
            highlight = {
              active-color = "#999999ff";
              urgent-color = "#ff9999ff";
              padding = 30;
              corner-radius = 0;
            };
            previews = {
              max-height = 480;
              max-scale = 0.5;
            };
            binds = {
              # Alt+Tab / Alt+Shift+Tab / Alt+grave / Alt+Shift+grave were commented
              # out in the source (left as reference)
              "Mod+Tab".next-window = { };
              "Mod+Shift+Tab".previous-window = { };
              "Mod+grave".next-window._props.filter = "app-id";
              "Mod+Shift+grave".previous-window._props.filter = "app-id";
            };
          };

          # ── binds.kdl ──
          binds = {
            "Alt+Print".screenshot-window = { };
            "Ctrl+Print".screenshot-screen = { };
            "Mod+0".focus-workspace = 10;
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };
            "Mod+C".center-column = { };

            "Mod+Ctrl+M".expand-column-to-available-width = { };
            "Mod+Ctrl+R".reset-window-height = { };

            "Mod+Equal".set-column-width = "+10%";

            "Mod+T".spawn = [ "xdg-terminal-exec" ];

            # For browsers specifically
            "Mod+F".spawn = [
              "wlr-which-key"
              "browsers"
            ];

            "Mod+D".spawn = [ "wlr-which-key" ];

            "Mod+E".spawn = [
              "wlr-which-key"
              "filemanagers"
            ];

            "Mod+X".spawn = [
              "wlr-which-key"
              "powermenu"
            ];

            "Mod+H".focus-column-left-or-last = { };
            "Mod+J".focus-window-down = { };
            "Mod+K".focus-window-up = { };
            "Mod+L".focus-column-right-or-first = { };

            # Open nix-search-tv
            "Mod+N".spawn-sh = "systemd-run --user kitty --title=nix-search-tv -e tv nix-search-tv";

            # Workspace down or up
            "Mod+U".focus-workspace-down = { };
            "Mod+I".focus-workspace-up = { };
            "Mod+Shift+U".move-window-to-workspace-down = { };
            "Mod+Shift+I".move-window-to-workspace-up = { };

            "Mod+M".maximize-column = { };
            "Mod+Minus".set-column-width = "-10%";
            "Mod+O" = {
              _props.repeat = false;
              toggle-overview = { };
            };
            "Mod+Period".expel-window-from-column = { };
            "Mod+Q".close-window = { };
            "Mod+Shift+Ctrl+E".quit = { };
            "Mod+Shift+Equal".set-window-height = "+10%";
            "Mod+Shift+H".move-column-left = { };
            "Mod+Shift+J".move-window-down = { };
            "Mod+Shift+K".move-window-up = { };
            "Mod+Shift+L".move-column-right = { };
            "Mod+Shift+M".maximize-window-to-edges = { };
            "Mod+Shift+Minus".set-window-height = "-10%";

            # Cycle through preset heights and widths — see window-rules.kdl
            "Mod+R".switch-preset-column-width = { };
            "Mod+Shift+R".switch-preset-window-height = { };

            "Mod+Shift+V".switch-focus-between-floating-and-tiling = { };
            "Mod+V".toggle-window-floating = { };
            "Mod+W".toggle-column-tabbed-display = { };

            # Toggle wallpaper selector
            "Print".screenshot = { };

            # Noctalia v5 settings — core Noctalia binds
            "Mod+Space".spawn-sh = "noctalia msg panel-toggle launcher";
            "Mod+S".spawn-sh = "noctalia msg panel-toggle control-center";
            "Mod+Comma".spawn-sh = "noctalia msg settings-toggle";

            # Audio & Brightness
            "XF86AudioRaiseVolume".spawn-sh = "noctalia msg volume-up";
            "XF86AudioLowerVolume".spawn-sh = "noctalia msg volume-down";
            "XF86AudioMute".spawn-sh = "noctalia msg volume-mute";
            "XF86MonBrightnessUp".spawn-sh = "noctalia msg brightness-up";
            "XF86MonBrightnessDown".spawn-sh = "noctalia msg brightness-down";

            "XF86AudioPlay".spawn-sh = "noctalia msg media toggle";
            "XF86AudioPause".spawn-sh = "noctalia msg media toggle";
            "XF86AudioNext".spawn-sh = "noctalia msg media next";
            "XF86AudioPrev".spawn-sh = "noctalia msg media previous";

            # ─── Workspace Switching ───
            "Mod+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              focus-workspace-down = { };
            };
            "Mod+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              focus-workspace-up = { };
            };
            "Mod+Ctrl+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              move-column-to-workspace-down = { };
            };
            "Mod+Ctrl+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              move-column-to-workspace-up = { };
            };

            "Mod+WheelScrollRight".focus-column-right = { };
            "Mod+WheelScrollLeft".focus-column-left = { };
            "Mod+Ctrl+WheelScrollRight".move-column-right = { };
            "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

            "Mod+Shift+WheelScrollDown".focus-column-right = { };
            "Mod+Shift+WheelScrollUp".focus-column-left = { };
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

            "Mod+Right".focus-monitor-next = { };
            "Mod+Shift+Right".move-window-to-monitor-next = { };
            "Mod+Left".focus-monitor-previous = { };
            "Mod+Shift+Left".move-window-to-monitor-previous = { };
          };

          # ── animations.kdl ──
          animations = {
            workspace-switch.spring._props = {
              damping-ratio = 1.0;
              stiffness = 1400;
              epsilon = 0.0001;
            };
            window-open = {
              duration-ms = 200;
              curve._args = [
                "cubic-bezier"
                0.34
                1.56
                0.64
                1
              ];
            };
            window-close = {
              duration-ms = 150;
              curve._args = [ "linear" ];
            };
            horizontal-view-movement.spring._props = {
              damping-ratio = 1.0;
              stiffness = 1400;
              epsilon = 0.0001;
            };
            window-movement.spring._props = {
              damping-ratio = 0.94;
              stiffness = 850;
              epsilon = 0.0001;
            };
            window-resize.spring._props = {
              damping-ratio = 0.94;
              stiffness = 850;
              epsilon = 0.0001;
            };
            config-notification-open-close = {
              duration-ms = 303;
              curve._args = [
                "cubic-bezier"
                0.15
                0
                0.1
                1
              ];
            };
            screenshot-ui-open = {
              duration-ms = 381;
              curve._args = [
                "cubic-bezier"
                0.23
                1
                0.32
                1
              ];
            };
            overview-open-close = {
              duration-ms = 400;
              curve._args = [
                "cubic-bezier"
                0.23
                1
                0.32
                1
              ];
            };
            recent-windows-close = {
              duration-ms = 150;
              curve._args = [ "linear" ];
            };
          };

          # ── outputs.kdl, layer-rules.kdl, window-rules.kdl ──
          # Repeated top-level node names (output, layer-rule, window-rule) have to
          # live under `_children` since a Nix attrset can't have duplicate keys.
          _children = [
            # -- outputs.kdl --
            {
              output = {
                _args = [ "eDP-1" ];
                focus-at-startup = { };
                mode = "1920x1080@60.056";
                transform = "normal";
              };
            }

            # -- layer-rules.kdl --
            # Set the overview wallpaper on the backdrop.
            {
              layer-rule = {
                match._props.namespace = "^noctalia-wallpaper*";
                place-within-backdrop = true;
              };
            }
            # Noctalia: blur everywhere without xray for a better look
            # (bar layer blur can be added under background-effect if wanted)
            {
              layer-rule = {
                match._props.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)\$";
                background-effect = {
                  xray = false;
                };
              };
            }
            {
              layer-rule = {
                match._props.namespace = "noctalia-window-switcher";
                background-effect = {
                  blur = true;
                  xray = false;
                };
              };
            }

            # -- window-rules.kdl --
            {
              window-rule = {
                clip-to-geometry = true;
                draw-border-with-background = false;
                geometry-corner-radius = 10;
                open-maximized = true;
              };
            }
            {
              window-rule = {
                match._props.is-floating = true;
                geometry-corner-radius =
                  let
                    r = 10.0;
                  in
                  [
                    r
                    r
                    r
                    r
                  ];
              };
            }
            {
              window-rule = {
                match._props.is-floating = false;
                shadow.off = { };
              };
            }
            {
              window-rule = {
                match._props.app-id = "dev.noctalia.Noctalia";
                open-floating = true;
                default-column-width.fixed = 1080;
                default-window-height.fixed = 920;
              };
            }
            {
              window-rule = {
                match._props.app-id = "pcmanfm";
                open-floating = true;
                open-focused = true;
                default-column-width.fixed = 900;
                default-window-height.fixed = 550;
              };
            }
            {
              window-rule = {
                match._props = {
                  app-id = "^firefox\$";
                  title = "^Picture-in-Picture\$";
                };
                open-floating = true;
                default-window-height.fixed = 220;
                default-floating-position._props = {
                  x = 1476;
                  y = 806;
                  relative-to = "top-left";
                };
              };
            }

            # For specific window bluring
            {
              window-rule = {
                match._props.app-id = "kitty";
                open-maximized = false;
                background-effect = {
                  blur = true;
                  xray = false;
                };
              };
            }
            {
              window-rule = {
                match._props.app-id = "org.pwmt.zathura";
                background-effect = {
                  blur = true;
                  xray = false;
                };
              };
            }

            {
              window-rule = {
                match._props.title = "nix-search-tv";
                open-floating = true;
                default-column-width.proportion = 0.75;
                default-window-height.proportion = 0.75;
              };
            }
            {
              window-rule = {
                match._props.title = "yazi_filemanager";
                open-floating = true;
                default-column-width.proportion = 0.75;
                default-window-height.proportion = 0.75;
              };
            }
          ];
        };
      };
    };
}
