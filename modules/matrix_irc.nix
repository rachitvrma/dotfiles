{
  flake.homeModules.matrix_irc = { config, ... }: {
    programs = {
      # For IRC
      halloy = {
        enable = true;
        settings = {
          notifications = {
            direct_message = {
              sound = "peck";
              show_toast = true;
            };
          };
          buffer.channel.topic = {
            enabled = true;
          };
          servers.Libera = {
            channels = [
              "#halloy"
              "#home-manager"
              "#archlinux-offtopic"
            ];
            nickname = "woodenAllen";
            server = "irc.libera.chat";
            use_tls = true;
            sasl.plain = {
              username = "woodenAllen";
              # Create {file}`~/.config/halloy/matrix_password`, put the correct password, and then
              # change the permission to 0600 using `chmod 0600 ~/.config/halloy/irc_password`
              password_file = "${config.xdg.configHome}/halloy/irc_password";
            };
          };
        };
      };

      # For matrix
      # Use cinny for a minimal WebUI
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
