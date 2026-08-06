{
  flake.homeModules.matrix_irc = { pkgs, ... }: {
    home.packages = [ pkgs.irssi ];
    programs = {
      # element-desktop.enable = true;
      # TODO: Configure Irssi and then transfer stuff here.
      /*
        irssi = {
          enable = true;
        };
      */
      iamb = {
        enable = true;
        settings = {
          default_profile = "main";
          profiles.main = {
            user_id = "@rachitvrma:matrix.org";
            url = "https://matrix.org";
          };
          layout.style = "restore";
          settings = {
            auto_focus_message_bar = true;
            external_edit_file_suffix = ".md";
            normal_after_send = true;
            image_preview = {
              protocol.type = "kitty";
            };
            mouse.enabled = true;
            sort.rooms = [
              "unread"
              "favorite"
              "lowpriority"
              "name"
            ];
            notifications = {
              enabled = true;
              sound_hint = "message-new-instant";
              via = "desktop";
              show_message = true;
            };
          };
        };
      };
    };
  };
}
