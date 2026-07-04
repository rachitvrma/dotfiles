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
      };
    };

    programs.dconf.enable = true;
    environment.systemPackages = [ pkgs.gnome-tweaks ];
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
