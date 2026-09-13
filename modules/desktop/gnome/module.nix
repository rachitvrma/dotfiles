{
  flake.nixosModules.gnome = { pkgs, ... }: {
    environment.gnome.excludePackages = with pkgs; [
      showtime # Video Player
      totem # Another video player, I guess
      gnome-music # Use EMMS from Emacs
      gnome-text-editor # I use Emacs already
      epiphany # Don't need another browser
      gnome-tour # Don't need that
      gnome-user-docs # don't need that either
    ];
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      accounts-daemon.enable = true;

      gnome = {
        # core-apps.enable = false;
        games.enable = false;
        gnome-browser-connector.enable = true;
        gnome-online-accounts.enable = true;
        gnome-user-share.enable = true;
        gnome-settings-daemon.enable = true;
        gnome-keyring.enable = true;

        sushi.enable = true;
        tinysparql.enable = true;
        rygel.enable = true;

        gnome-remote-desktop.enable = true;
      };
    };

    programs = {
      gnome-disks.enable = true;
      calls.enable = true;
      nm-applet.enable = true;

      gnupg.agent.pinentryPackage = pkgs.pinentry-gnome3;

      nautilus-open-any-terminal = {
        enable = true;
      };
      dconf.profiles = {
        # A "user" profile with a database
        user.databases = [
          {
            settings = {
              "org/gnome/mutter" = {
                experimental-features = [
                  "autoclose-xwayland"
                  "scale-monitor-framebuffer" # fractional scaling (125%/150%/etc.)
                  "variable-refresh-rate" # VRR/FreeSync, if your monitor supports it
                ];
              };
            };
          }
        ];
      };
    };
  };

  flake.homeModules.gnome = { pkgs, lib, ... }: {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        # 12h clock format
        clock-format = "12h";
        # Show battery percentage in the top-bar
        show-battery-percentage = true;
        # Show weekdays
        clock-show-weekday = true;
        # Show seconds in the top bar clock
        clock-show-seconds = true;
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = true; # sunset-to-sunrise via geoclue
        night-light-temperature = lib.hm.gvariant.mkUint32 4000; # default warmth
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      # Corresponts to the list of extensions installed below
      "org/gnome/shell".enable-extensions = [
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "Vitals@CoreCoding.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];

      # Enable/Disable location services. I enable it for switching to Night Mode
      "org/gnome/system/location".enabled = true;
      # Enable/Disable automatic timezone. Requires location services enabled.
      "org/gnome/desktop/datetime".automatic-timezone = true;
      # Show weekdate in the drop down calendar
      "org/gnome/desktop/calendar".show-weekdate = true;
    };
    xdg = {
      portal = {
        configPackages = [ pkgs.gnome-session ];
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      };
    };
    programs = {
      gnome-shell = {
        enable = true;

        # UUID is filled in automatically, but if it's ever needed
        # nix eval nixpkgs#gnomeExtensions.caffeine.extensionUuid
        # Will tell the id value of that particular extension
        extensions = [
          { package = pkgs.gnomeExtensions.caffeine; }
          { package = pkgs.gnomeExtensions.clipboard-indicator; }
          { package = pkgs.gnomeExtensions.vitals; }
          { package = pkgs.gnomeExtensions.user-themes; }
        ];
      };

      # gnome-console is the more minimalistic one
      gnome-terminal = {
        enable = false;
        profile = {
          "30effd58-b1b0-44d7-a97c-8f033d617f65" = {
            default = true;
            visibleName = "Default";
          };
        };
      };

      # My pdf/epub reader
      foliate = {
        enable = true;
      };
    };

    services = {
      gnome-keyring.enable = true;
      polkit-gnome.enable = true;
      gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
    };
  };
}
