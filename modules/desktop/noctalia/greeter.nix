{
  flake.nixosModules.noctalia_greeter = { config, ... }: {
    services.displayManager.noctalia-greeter = {
      enable = true;
      # passwordlessSyncUsers = true;
      cursorTheme = {
        name = config.stylix.cursor.name;
        package = config.stylix.cursor.package;
      };
      settings = {
        cursor = {
          size = config.stylix.cursor.size;
          theme = config.stylix.cursor.name;
        };
        keyboard = {
          inherit (config.services.xserver.xkb)
            layout
            variant
            options
            ;
          numlock = true;
        };
        user = {
          default = "krish";
        };
        appearance = {
          scheme = "Synced";
          password_style = "random";
          hide_logo = true;
          font_family = "monospace";
        };
        auth = {
          allow_empty_password = false;
          request_timeout = 60;
        };
      };
    };
    # Waiting for the PR to merge
    /*
        security.polkit = {
          enable = true;
          extraConfig = ''
            polkit.addRule(function(action, subject) {
              var allowedUsers = ["alice"];

              if (action.id == "org.noctalia.greeter.sync-appearance" &&
                  action.lookup("program") == "${pkgs.noctalia-greeter}/bin/noctalia-greeter-apply-appearance" &&
                  action.lookup("user") == "root" &&
                  subject.local && subject.active &&
                  allowedUsers.indexOf(subject.user) >= 0) {
                return polkit.Result.YES;
              }
            });
          '';
        };
    */
  };
}
