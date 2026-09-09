{
  flake.homeModules.matrix_irc = { config, ... }: {
    programs = {
      # For matrix
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
              via = "desktop";
              show_message = true;
              sound_hint = "message-new-instant";
            };
          };
        };
      };
    };
  };
}
