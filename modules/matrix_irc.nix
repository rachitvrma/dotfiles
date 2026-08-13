{
  flake.nixosModules.matrix_irc = {
    services.soju = {
      enable = true;
      hostName = "localhost";
      listen = [ "irc+insecure://127.0.0.1:6667" ];
      adminSocket.enable = true;
    };
  };
  flake.homeModules.matrix_irc = { ... }: {
    stylix.targets.halloy.fonts.override = {
      sizes.applications = 14;
    };
    programs = {
      # For IRC
      senpai = {
        enable = true;
        config = {
          # address = "irc.libera.chat";
          address = "irc+insecure://127.0.0.1:6667";
          nickname = "woodenAllen";
          password-cmd = [
            "pass"
            "show"
            "irc/libera"
          ];
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
