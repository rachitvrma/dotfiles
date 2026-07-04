{
  flake.nixosModules.gnome = { pkgs, ... }: {
    # Enable the X11 windowing system.
    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      gnome = {
        gnome-keyring.enable = true;
        gnome-settings-daemon.enable = true;
        gnome-browser-connector.enable = true;
        localsearch.enable = true;
        sushi.enable = true;
        tinysparql.enable = true;
        gnome-initial-setup.enable = true;

        # core-apps.enable = false;
        core-developer-tools.enable = false;
        games.enable = false;
      };

    };
    programs.dconf.enable = true;

    environment = {
      gnome.excludePackages = with pkgs; [
        cheese # webcam booth, rarely needed on a laptop
        decibels
        epiphany # if you don't intend to use GNOME Web at all
        evolution
        geary # you use emacs (gnupg/notmuch/mu4e presumably) for mail
        gedit # or gnome-text-editor, if you don't want it alongside Emacs
        gnome-characters
        gnome-contacts # mobile-convergence leftover, no use on a laptop
        gnome-maps
        gnome-music
        gnome-text-editor
        gnome-tour
        gnome-user-docs
        gnome-weather
        showtime
        totem # you use mpv/EMMS
        epiphany
        yelp
      ];
      systemPackages = [ pkgs.gnome-tweaks ];
    };
  };

  flake.homeModules.gnome = { pkgs, ... }: {
    services.gnome-keyring.enable = true;
    programs = {
      gnome-shell = {
        enable = true;
        theme = {
          package = pkgs.gruvbox-gtk-theme.override {
            colorVariants = [ "dark" ];
            sizeVariants = [ "standard" ];
            themeVariants = [ "pink" ];
            tweakVariants = [
              "macos"
              "medium"
            ];
            iconVariants = [ "Dark" ];
          };
          name = "Gruvbox-Pink-Dark-Medium";
        };

        extensions = [
          { package = pkgs.gnomeExtensions.gsconnect; }
          { package = pkgs.gnomeExtensions.applications-menu; }
        ];
      };
    };
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          clock-show-weekday = true;
          clock-show-date = true;
          clock-format = "12h"; # or "24h"
          # accent-color = "purple";
          gtk-key-theme = "Emacs";
        };
      };
    };
  };
}
