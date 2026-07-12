{
  flake.nixosModules.hyprland = { pkgs, config, ... }: {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = false;
      };
      hyprlock.enable = true;
    };
    services.hypridle.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      # I am guessing it's configured by default
      configPackages = [
        config.programs.hyprland.package
      ];
    };
  };

  flake.homeModules.hyprland =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      xdg = {
        portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
          ];
        };
        configFile."uwsm/env".source =
          "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
      };

      home = {
        pointerCursor.hyprcursor.enable = true;
        packages = with pkgs; [
          hyprshutdown
          brightnessctl
          kitty
          trash-cli
        ];
      };
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = false;
        systemd.enable = false;

        settings =
          let
            luaInLine = lib.generators.mkLuaInline;
          in
          {
            mod._var = "SUPER";
            menu._var = "hyprlauncher";

            monitor = {
              output = "";
              mode = "preferred";
              position = "auto";
              scale = 1;
            };

            permission = [
              {
                binary = lib.getExe pkgs.grim;
                type = "screencopy";
                mode = "allow";
              }
              {
                binary = lib.escapeRegex (lib.getExe config.programs.hyprlock.package);
                type = "screencopy";
                mode = "allow";
              }
              {
                binary = "${pkgs.xdg-desktop-portal-hyprland}/libexec/.xdg-desktop-portal-hyprland-wrapped";
                type = "screencopy";
                mode = "allow";
              }
            ];

            # from default: XCURSOR_SIZE / HYPRCURSOR_SIZE
            env = [
              {
                _args = [
                  "XCURSOR_SIZE"
                  "24"
                ];
              }
              {
                _args = [
                  "HYPRCURSOR_SIZE"
                  "24"
                ];
              }
            ];

            config = {
              input = {
                kb_layout = "us";
                kb_variant = "colemak_dh";
                kb_options = "caps:swapescape";

                follow_mouse = 1;
                sensitivity = 0;

                numlock_by_default = true;
                repeat_delay = 250;
                repeat_rate = 35;
                off_window_axis_events = 2;

                touchpad = {
                  natural_scroll = true;
                  disable_while_typing = true;
                  clickfinger_behavior = true;
                  scroll_factor = 0.7;
                };
              };

              general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 1;

                # from default: active/inactive border colors
                col = {
                  active_border = {
                    colors = [
                      "rgba(d3869bee)"
                      "rgba(d8a657ee)"
                    ];
                    angle = 45;
                  };
                  inactive_border = "rgba(595959aa)";
                };

                resize_on_border = false;
                allow_tearing = false;

                layout = "dwindle";

                no_focus_fallback = true;
                snap = {
                  enabled = true;
                  window_gap = 4;
                  monitor_gap = 5;
                  respect_gaps = true;
                };
              };

              decoration = {
                rounding = 18;
                # from default
                rounding_power = 2.5;

                active_opacity = 1.0;
                inactive_opacity = 1.0;

                shadow = {
                  enabled = true;
                  range = 20;
                  offset = [
                    0
                    2
                  ];
                  render_power = 10;
                  color = "rgba(00000020)";
                };
                dim_inactive = true;
                dim_strength = 0.05;
                dim_special = 0.2;

                blur = {
                  enabled = true;
                  xray = true;
                  special = false;
                  new_optimizations = true;
                  size = 10;
                  passes = 3;
                  brightness = 1;
                  noise = 0.05;
                  contrast = 0.89;
                  vibrancy = 0.5;
                  vibrancy_darkness = 0.5;
                  popups = false;
                  popups_ignorealpha = 0.6;
                  input_methods = true;
                  input_methods_ignorealpha = 0.8;
                };
              };

              animations.enabled = true;

              scrolling = {
                fullscreen_on_one_column = true;
                column_width = 0.9;
                direction = "right";
              };

              dwindle = {
                preserve_split = true;
                smart_split = false;
                smart_resizing = false;
              };

              misc = {
                # force_default_wallpaper = -1;
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
                # vrr = 0;
                mouse_move_enables_dpms = true;
                key_press_enables_dpms = true;
                animate_manual_resizes = false;
                animate_mouse_windowdragging = false;
                enable_swallow = false;
                swallow_regex = "(foot|kitty|allacritty|Alacritty)";
                on_focus_under_fullscreen = 2;
                allow_session_lock_restore = true;
                session_lock_xray = true;
                initial_workspace_tracking = false;
                focus_on_activate = true;
              };

              binds = {
                scroll_event_delay = 0;
                hide_special_on_workspace_change = true;
                workspace_back_and_forth = true;
              };

              cursor = {
                zoom_factor = 1;
                zoom_rigid = false;
                zoom_disable_aa = true;
                hotspot_padding = 1;
              };
            };

            # from default: 3-finger horizontal swipe -> workspace switch
            gesture = [
              {
                fingers = 4;
                direction = "horizontal";
                action = "workspace";
              }
              {
                fingers = 3;
                direction = "swipe";
                action = "move";
              }
              {
                fingers = 3;
                direction = "pinch";
                action = "fullscreen";
              }
            ];

            bind = [
              # window management
              {
                _args = [
                  (luaInLine "mod .. \" + Q\"")
                  (luaInLine "hl.dsp.window.close()")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + SHIFT + F\"")
                  (luaInLine "hl.dsp.window.fullscreen({mode = \"fullscreen\", action = \"toggle\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + F\"")
                  (luaInLine "hl.dsp.window.fullscreen({mode = \"maximized\", action = \"toggle\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + RETURN\"")
                  (luaInLine "hl.dsp.exec_cmd(\"uwsm-terminal -T\")")
                ];
              }
              # from default: file manager, float toggle, pseudo, exit fallback
              {
                _args = [
                  (luaInLine "mod .. \" + E\"")
                  (luaInLine "hl.dsp.exec_cmd(\"dolphin\")")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + V\"")
                  (luaInLine "hl.dsp.window.float({action = \"toggle\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + P\"")
                  (luaInLine "hl.dsp.window.pseudo()")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + M\"")
                  (luaInLine "hl.dsp.exec_cmd(\"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'\")")
                ];
              }

              # focus movement (hjkl, physical QWERTY position)
              {
                _args = [
                  (luaInLine "mod .. \" + l\"")
                  (luaInLine "hl.dsp.focus({direction = \"right\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + h\"")
                  (luaInLine "hl.dsp.focus({direction = \"left\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + k\"")
                  (luaInLine "hl.dsp.focus({direction = \"up\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + j\"")
                  (luaInLine "hl.dsp.focus({direction = \"down\"})")
                ];
              }

              # move windows around
              {
                _args = [
                  (luaInLine "mod .. \" + SHIFT + l\"")
                  (luaInLine "hl.dsp.window.move({direction = \"right\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + SHIFT + h\"")
                  (luaInLine "hl.dsp.window.move({direction = \"left\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + SHIFT + k\"")
                  (luaInLine "hl.dsp.window.move({direction = \"up\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + SHIFT + j\"")
                  (luaInLine "hl.dsp.window.move({direction = \"down\"})")
                ];
              }

              # from default: special workspace scratchpad
              {
                _args = [
                  (luaInLine "mod .. \" + S\"")
                  (luaInLine "hl.dsp.workspace.toggle_special(\"magic\")")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + SHIFT + S\"")
                  (luaInLine "hl.dsp.window.move({workspace = \"special:magic\"})")
                ];
              }

              # from default: scroll through workspaces
              {
                _args = [
                  (luaInLine "mod .. \" + mouse_down\"")
                  (luaInLine "hl.dsp.focus({workspace = \"e+1\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + mouse_up\"")
                  (luaInLine "hl.dsp.focus({workspace = \"e-1\"})")
                ];
              }

              # For workspaces
              {
                _args = [
                  (luaInLine "mod .. \" + bracketleft\"")
                  (luaInLine "hl.dsp.focus({workspace = \"e-1\"})")
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + bracketright\"")
                  (luaInLine "hl.dsp.focus({workspace = \"e+1\"})")
                ];
              }

              # from default: move/resize windows with mouse
              {
                _args = [
                  (luaInLine "mod .. \" + mouse:272\"")
                  (luaInLine "hl.dsp.window.drag()")
                  { mouse = true; }
                ];
              }
              {
                _args = [
                  (luaInLine "mod .. \" + mouse:273\"")
                  (luaInLine "hl.dsp.window.resize()")
                  { mouse = true; }
                ];
              }

              # launch menu using hyprlauncher
              {
                _args = [
                  (luaInLine "mod .. \" + d\"")
                  (luaInLine "hl.dsp.exec_cmd(menu)")
                ];
              }

              # from default: laptop multimedia / brightness keys
              {
                _args = [
                  "XF86AudioRaiseVolume"
                  (luaInLine "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "XF86AudioLowerVolume"
                  (luaInLine "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "XF86AudioMute"
                  (luaInLine "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "XF86AudioMicMute"
                  (luaInLine "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "XF86MonBrightnessUp"
                  (luaInLine "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "XF86MonBrightnessDown"
                  (luaInLine "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  "XF86AudioNext"
                  (luaInLine "hl.dsp.exec_cmd(\"playerctl next\")")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  "XF86AudioPause"
                  (luaInLine "hl.dsp.exec_cmd(\"playerctl play-pause\")")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  "XF86AudioPlay"
                  (luaInLine "hl.dsp.exec_cmd(\"playerctl play-pause\")")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  "XF86AudioPrev"
                  (luaInLine "hl.dsp.exec_cmd(\"playerctl previous\")")
                  { locked = true; }
                ];
              }
            ];

            # from default: window rules
            window_rule = [
              {
                name = "suppress-maximize-events";
                match.class = ".*";
                suppress_event = "maximize";
              }
              {
                name = "fix-xwayland-drags";
                match = {
                  class = "^$";
                  title = "^$";
                  xwayland = true;
                  float = true;
                  fullscreen = false;
                  pin = false;
                };
                no_focus = true;
              }
            ];

            curve = [
              {
                _args = [
                  "easeInOutCubic"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.65
                        0.05
                      ]
                      [
                        0.36
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "easeOutQuint"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.23
                        1
                      ]
                      [
                        0.32
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "linear"
                  {
                    type = "bezier";
                    points = [
                      [
                        0
                        0
                      ]
                      [
                        1
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "almostLinear"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.5
                        0.5
                      ]
                      [
                        0.75
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "quick"
                  {
                    type = "bezier";
                    points = [
                      [
                        0.15
                        0
                      ]
                      [
                        0.1
                        1
                      ]
                    ];
                  }
                ];
              }
              {
                _args = [
                  "easy"
                  {
                    type = "spring";
                    mass = 1;
                    stiffness = 71.2633;
                    dampening = 15.8273644;
                    # points = [
                    #   [
                    #     0
                    #     0
                    #   ]
                    #   [
                    #     1
                    #     1
                    #   ]
                    # ];
                  }
                ];
              }
            ];

            animation = [
              {
                leaf = "global";
                enabled = true;
                speed = 10;
                bezier = "default";
              }
              {
                leaf = "border";
                enabled = true;
                speed = 5.39;
                bezier = "easeOutQuint";
              }
              {
                leaf = "windows";
                enabled = true;
                speed = 4.79;
                spring = "easy";
              }
              {
                leaf = "windowsIn";
                enabled = true;
                speed = 4.1;
                spring = "easy";
                style = "popin 87%";
              }
              # from default: the rest of the animation leaves
              {
                leaf = "windowsOut";
                enabled = true;
                speed = 1.49;
                bezier = "linear";
                style = "popin 87%";
              }
              {
                leaf = "fadeIn";
                enabled = true;
                speed = 1.73;
                bezier = "almostLinear";
              }
              {
                leaf = "fadeOut";
                enabled = true;
                speed = 1.46;
                bezier = "almostLinear";
              }
              {
                leaf = "fade";
                enabled = true;
                speed = 3.03;
                bezier = "quick";
              }
              {
                leaf = "layers";
                enabled = true;
                speed = 3.81;
                bezier = "easeOutQuint";
              }
              {
                leaf = "layersIn";
                enabled = true;
                speed = 4;
                bezier = "easeOutQuint";
                style = "fade";
              }
              {
                leaf = "layersOut";
                enabled = true;
                speed = 1.5;
                bezier = "linear";
                style = "fade";
              }
              {
                leaf = "fadeLayersIn";
                enabled = true;
                speed = 1.79;
                bezier = "almostLinear";
              }
              {
                leaf = "fadeLayersOut";
                enabled = true;
                speed = 1.39;
                bezier = "almostLinear";
              }
              {
                leaf = "workspaces";
                enabled = true;
                speed = 1.94;
                bezier = "almostLinear";
                style = "fade";
              }
              {
                leaf = "workspacesIn";
                enabled = true;
                speed = 1.21;
                bezier = "almostLinear";
                style = "fade";
              }
              {
                leaf = "workspacesOut";
                enabled = true;
                speed = 1.94;
                bezier = "almostLinear";
                style = "fade";
              }
              {
                leaf = "zoomFactor";
                enabled = true;
                speed = 7;
                bezier = "quick";
              }
            ];
          };

        extraConfig = /* lua */ ''
          -- Switch workspaces with mod + [0-9]
          -- Move active window to a workspace with mod + SHIFT + [0-9]
          for i = 1, 10 do
              local key = i % 10 -- 10 maps to key 0
              hl.bind(mod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
              hl.bind(mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
          end
        '';
      };

      services = {
        hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || hyprlock";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
            };
            listener = [
              {
                timeout = 150;
                on-timeout = "brightnessctl -s set 10";
                on-resume = "brightnessctl -r";
              }
              {
                timeout = 300;
                on-timeout = "loginctl lock-session";
              }
              {
                timout = 330;
                on-timeout = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
                on-resume = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' && brightnessctl -r";
              }
              {
                timeout = 1800;
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };
        hyprsunset.enable = true;
        hyprpaper = {
          enable = true;
          settings = {
            splash = false;
            wallpaper =
              let
                src = pkgs.fetchurl {
                  url = "https://gruvbox-wallpapers.pages.dev/wallpapers/photography/castle.jpg";
                  hash = "sha256-OHRzLcnenyZvQ0Q3pRx/tM5PBKw0hta+/YTo37tXRKc=";
                };
              in
              [
                {
                  monitor = "eDP-1";
                  path = "${src}";
                }
              ];
          };
        };
        hyprpolkitagent.enable = true;

        hyprlauncher = {
          enable = true;
          settings = {
            desktop_launch_prefix = "uwsm-app --";
            desktop_icons = true;
          };
        };
      };

      programs = {
        hyprlock = {
          enable = true;
          settings = {
            general = {
              hide_cursor = true;
              ignore_empty_input = true;
            };

            animations = {
              enabled = true;
              fade_in = {
                duration = 300;
                bezier = "easeOutQuint";
              };
              fade_out = {
                duration = 300;
                bezier = "easeOutQuint";
              };
            };

            background = [
              {
                path = "screenshot";
                blur_passes = 3;
                blur_size = 8;
              }
            ];

            input-field = [
              {
                size = "200, 50";
                position = "0, -80";
                monitor = "";
                dots_center = true;
                fade_on_empty = false;
                font_color = "rgb(202, 211, 245)";
                inner_color = "rgb(91, 96, 120)";
                outer_color = "rgb(24, 25, 38)";
                outline_thickness = 5;
                placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
                shadow_passes = 2;
              }
            ];
          };
        };
        hyprshot.enable = true;
      };
    };
}
