{
  flake.nixosModules.sway = { pkgs, ... }: {
    programs = {
      dconf.enable = true;
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraPackages = with pkgs; [
          brightnessctl
          kitty
          grim
          # swayidle
          swaylock
          swaybg
          wmenu
          playerctl
        ];
      };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };

    services = {
      udisks2.enable = true;
      gvfs.package = pkgs.gvfs.override { gnomeSupport = false; };
      gnome.gnome-keyring.enable = true;
      playerctld.enable = true;

      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
            user = "greeter";
          };
        };
      };
    };

    security = {
      polkit.enable = true;
      pam.services = {
        greetd.enableGnomeKeyring = true;
        swaylock = {
          enableGnomeKeyring = true;
        };
      };
    };
  };

  flake.homeModules.sway =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      xdg = {
        portal = {
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
          ];
          config.common.default = "*";
        };
      };
      home = {
        packages = with pkgs; [
          (j4-dmenu-desktop.override {
            dmenu = pkgs.wmenu;
          })
          sway-audio-idle-inhibit
          libnotify
        ];
        pointerCursor.sway = {
          enable = true;
        };
      };
      wayland.windowManager.sway = {
        enable = true;

        wrapperFeatures = {
          base = true;
          gtk = true;
        };

        checkConfig = true;

        config =
          let
            wmenuArgs = [
              # behavior
              "-i" # case-insensitive matching
              "-b" # anchor to bottom of screen
              "-l"
              "10" # show 10 lines vertically

              # font
              "-f"
              "monospace 11"

              # colors — Gruvbox Material Dark Hard
              "-N"
              "141617" # normal background   (base00)
              "-n"
              "ddc7a1" # normal foreground   (base05)
              "-M"
              "1d2021" # prompt background   (base01)
              "-m"
              "d3869b" # prompt foreground   (base0E)
              "-S"
              "282828" # selected background (base02)
              "-s"
              "d3869b" # selected foreground (base0E)
            ];
            wmenuThemed = pkgs.writeShellScript "wmenu-themed" ''
              exec ${pkgs.wmenu}/bin/wmenu ${lib.escapeShellArgs wmenuArgs} "$@"
            '';
          in
          {
            terminal = "xdg-terminal-exec || ${pkgs.kitty}/bin/kitty";
            defaultWorkspace = "workspace number 1";
            workspaceAutoBackAndForth = true;

            startup = [
              { command = "sleep 3s && sway-audio-idle-inhibit"; }
            ];

            focus = {
              followMouse = "yes";
              wrapping = "yes"; # Default value in sway(5)
            };

            fonts = {
              names = [
                "JetBrainsMono Nerd Fonts"
              ];
              style = "Mono";
              size = 9.5;
            };

            gaps = {
              inner = 12;
              outer = 5;
              smartBorders = "on";
            };

            # BUG: There's actually no way to set it csd or none, which are options in sway(5)
            # Just look at the home-manager module.
            window.titlebar = false;

            modifier = "Mod4";

            menu = "j4-dmenu-desktop --dmenu=${wmenuThemed} --no-exec | xargs -r swaymsg exec --";

            input = {
              "*" = {
                xkb_layout = "us";
                xkb_variant = "colemak_dh";
                # xkb_options = "ctrl:swapcaps";
                xkb_options = "caps:swapescape";
              };

              "type:touchpad" = {
                tap = "enabled";
                natural_scroll = "enabled";
                dwt = "enabled";
              };
            };

            output =
              let
                src = pkgs.fetchurl {
                  url = "https://gruvbox-wallpapers.pages.dev/wallpapers/mix/platform.jpg";
                  hash = "sha256-ZQsr2w8vzwPrWvaU7sAE69d8ouetpwe8nkBKeIGx58U=";
                };
              in
              {
                eDP-1 = {
                  bg = "${src} fill";
                };
              };
            seat = {
              "*" = {
                hide_cursor = "when-typing enable";
              };
            };

            keybindings =
              let
                powermenu = pkgs.writeShellScriptBin "powermenu" ''
                  set -euo pipefail

                  chosen=$(printf '%s\n' "Lock" "Logout" "Suspend" "Hibernate" "Reboot" "Shutdown" \
                    | wmenu -i -p "power" \
                        -N '#141617' -n '#ddc7a1' \
                        -S '#d3869b' -s '#141617' \
                        -f "JetBrainsMono Nerd Font 11")

                  case "$chosen" in
                    Lock)      exec swaylock ;;
                    Logout)    exec swaymsg exit ;;
                    Suspend)   exec systemctl suspend ;;
                    Hibernate) exec systemctl hibernate ;;
                    Reboot)    exec systemctl reboot ;;
                    Shutdown)  exec systemctl poweroff ;;
                    *) exit 0 ;; # empty selection / Escape
                  esac
                '';
                mod = config.wayland.windowManager.sway.config.modifier;
                num_of_workspaces = 10;
                workspaceAwk = pkgs.writeText "workspace.gawk" /* bash */ ''
                  $3 == "(focused)" {
                  	switch(move_type) {
                  	case "left":
                  		if ($2 == 1)
                  			$2=num_of_workspaces+1
                  		system("sway workspace "$2-1)
                  		exit
                  	
                  	case "right":
                  		if ($2 == num_of_workspaces)
                  			$2=0
                  		system("sway workspace "$2+1)
                  		exit
                  	
                  	case "container_left":
                  		if ($2 == 1)
                  			$2=num_of_workspaces+1
                  		system("sway move container to workspace "$2-1", workspace "$2-1)
                  		exit
                  	
                  	case "container_right":
                  		if ($2 == num_of_workspaces)
                  			$2=0
                  		system("sway move container to workspace "$2+1", workspace "$2+1)
                  		exit
                  	}
                  }
                '';
                bind =
                  moveType:
                  "exec swaymsg -pt get_workspaces | ${pkgs.gawk}/bin/gawk -f ${workspaceAwk} -v move_type=${moveType} -v num_of_workspaces=${toString num_of_workspaces}";

              in
              lib.mkOptionDefault {
                "${mod}+q" = "kill";
                "${mod}+c" = "exec cliphist list | ${wmenuThemed} | cliphist decode | wl-copy";

                "${mod}+n" = "split none";

                "${mod}+u" = "workspace next";
                "${mod}+i" = "workspace prev";
                "${mod}+shift+u" = "move container to workspace next, workspace next";
                "${mod}+shift+i" = "move container to workspace prev, workspace prev";

                "${mod}+escape" = "exec ${lib.getExe powermenu}";

                "${mod}+ctrl+u" = bind "right";
                "${mod}+ctrl+i" = bind "left";
                "${mod}+ctrl+shift+u" = bind "container_right";
                "${mod}+ctrl+shift+i" = bind "container_left";

                "${mod}+shift+Return" = "exec emacsclient -ca \"emacs\"";

                # Special keys to adjust volume via PulseAudio
                "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
                "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
                "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                "--locked XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

                # Special keys to control media via playerctl
                "--locked XF86AudioPlay" = "exec playerctl play-pause";
                "--locked XF86AudioPause" = "exec playerctl play-pause";
                "--locked XF86AudioPrev" = "exec playerctl previous";
                "--locked XF86AudioNext" = "exec playerctl next";
                "--locked XF86AudioStop" = "exec playerctl stop";

                # Special keys to adjust brightness via brightnessctl
                "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
                "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
              };

            colors = {
              background = "#141617"; # base00
              focused = {
                background = "#282828"; # base02
                border = "#d3869b"; # base0E — primary accent (magenta), consistent with your mpv mPrimary swap
                childBorder = "#d3869b";
                indicator = "#7daea3"; # base0D — secondary accent (blue), consistent with mpv mSecondary
                text = "#fbf1c7"; # base07 — light text, fine here since it's on a dark bar, not the wallpaper
              };
              focusedInactive = {
                background = "#1d2021"; # base01
                border = "#5a524c"; # base03 — muted, but still saturated-neutral enough to read against light bg
                childBorder = "#1d2021"; # base01
                indicator = "#5a524c"; # base03
                text = "#bdae93"; # base04
              };
              placeholder = {
                background = "#141617"; # base00
                border = "#141617"; # base00
                childBorder = "#141617"; # base00
                indicator = "#141617"; # base00
                text = "#ddc7a1"; # base05
              };
              unfocused = {
                background = "#1d2021"; # base01
                border = "#1d2021"; # base01 — deliberately dark/low-contrast so unfocused windows recede
                childBorder = "#1d2021"; # base01
                indicator = "#282828"; # base02
                text = "#5a524c"; # base03 — muted, unfocused windows shouldn't compete for attention
              };
              urgent = {
                background = "#ea6962"; # base08 — red, unambiguous against any background including light wallpapers
                border = "#ea6962"; # base08
                childBorder = "#ea6962"; # base08
                indicator = "#ea6962"; # base08
                text = "#141617"; # base00 — dark text on red reads better than white-on-red at a glance
              };
            };

            # Empty bars list stops the default bar list from working
            # Which pulls in i3status command
            bars = [ ];

            bindswitches =
              let
                laptop = "eDP-1";
              in
              {
                "lid:on" = {
                  reload = true;
                  locked = true;
                  action = "output ${laptop} disable";
                };
                "lid:off" = {
                  reload = true;
                  locked = true;
                  action = "output ${laptop} enable";
                };
              };

          };

        extraConfig = ''
          bindgesture swipe:left workspace next
          bindgesture swipe:right workspace prev
        '';
      };

      programs = {
        swaylock =
          let
            src = pkgs.fetchurl {
              url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/finalizer.png";
              hash = "sha256-I1g+sVwIbjo4JOW5LIf7anYY7kJLT5ckPY0peplkG0U=";
            };
          in
          {
            enable = true;

            settings = {
              daemonize = true;
              color = "141617";
              font-size = 24;
              indicator-idle-visible = false;
              indicator-radius = 100;
              line-color = "ddc7a1";
              show-failed-attempts = true;
              image = lib.mkForce src;
            };
          };

        swayimg = {
          enable = true;
        };
      };

      services = {
        playerctld.enable = true;
        udiskie.enable = true;

        batsignal = {
          enable = true;
          extraArgs = [
            "-w"
            "40" # warning level
            "-c"
            "30" # critical level
            "-d"
            "20" # danger level
            "-f"
            "80" # full-battery notification (0 disables; 97-99 is the usual choice since some batteries never report exactly 100)
            "-m"
            "60" # min seconds between checks
          ];
        };

        wlsunset = {
          enable = true;
          sunset = "18:00";
          sunrise = "06:00";
        };

        mako = {
          enable = true;
          settings = {
            "actionable=true" = {
              anchor = "top-left";
            };
            "urgency=low" = {
              border-color = "#89b482"; # base0C aqua - quiet/informational
            };
            "urgency=normal" = {
              border-color = "#d3869b"; # base0E magenta - your primary
            };
            "urgency=critical" = {
              border-color = "#ea6962"; # base08 red - stands out regardless of theme
            };

            actions = true;
            anchor = "top-right";
            background-color = "#1d2021";
            text-color = "#d4be98";
            border-color = "#7daea3";
            font = "monospace 10";
            border-size = 2;
            border-radius = 8;
            default-timeout = 0;
            height = 100;
            icons = true;
            max-icon-size = 48;
            ignore-timeout = false;
            layer = "overlay";
            margin = 10;
            padding = "10,15";
            markup = true;
            width = 320;
          };
        };

        swayidle =
          let
            # Lock command
            lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
            # Sway
            display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
          in
          {
            enable = true;
            timeouts = [
              {
                timeout = 30; # in seconds
                command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
              }
              {
                timeout = 40;
                command = lock;
              }
              {
                timeout = 50;
                command = display "off";
                resumeCommand = display "on";
              }
              {
                timeout = 120;
                command = "${pkgs.systemd}/bin/systemctl suspend";
              }
            ];
            events = {
              # adding duplicated entries for the same event may not work
              before-sleep = (display "off") + "; " + lock;
              after-resume = display "on";
              lock = (display "off") + "; " + lock;
              unlock = display "on";
            };
          };

        cliphist = {
          enable = true;
        };
      };
    };
}
