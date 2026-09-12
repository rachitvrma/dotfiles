{
  flake.nixosModules.gnome = { pkgs, ... }: {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      gnome = {
        # core-apps.enable = false;
        games.enable = false;
        gnome-browser-connector.enable = true;
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
        terminal = "kitty";
      };
      dconf.profiles = {
        # A "user" profile with a database
        user.databases = [
          {
            settings = {
              "org/gnome/mutter" = {
                experimental-features = [
                  "autoclose-xwayland"
                ];
              };
            };
          }
        ];
      };
    };
  };

  flake.homeModules.gnome = { pkgs, ... }: {
    xdg = {
      portal = {
        configPackages = [ pkgs.gnome-session ];
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      };
    };
    programs = {
      gnome-shell.enable = true;
      gnome-terminal = {
        enable = true;
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
