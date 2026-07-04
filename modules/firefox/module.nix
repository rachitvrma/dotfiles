{
  flake.nixosModules.firefox = {
    # Install firefox.
    programs.firefox.enable = true;
  };

  flake.homeModules.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = with pkgs; [
        gnome-browser-connector
        tridactyl-native
      ];

      # TODO: there's something wrong with the ln command in the derivation here
      # See todo.org
      # pkcs11Modules = [ pkgs.p11-kit ];

      package = pkgs.firefox.override {
        nativeMessagingHosts = [
          # Gnome shell native connector
          pkgs.gnome-browser-connector
          # Tridactyl native connector
          pkgs.tridactyl-native
        ];
      };

      policies = import ./_policies.nix { inherit pkgs; };

      profiles.krish = {
        isDefault = true;
        id = 0;
        name = "krish";
        settings = import ./_prefs.nix;

        containers = {
          Work = {
            id = 1;
            color = "blue";
            icon = "briefcase";
          };
        };
        containersForce = true;
      };
    };
    xdg.mimeApps = {
      associations.added = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
      };
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
