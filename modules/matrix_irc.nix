{
  flake.homeModules.matrix_irc = { config, ... }: {
    xdg.autostart.entries = [
      "${config.programs.halloy.package}/share/applications/org.squidowl.halloy.desktop"
      "${config.programs.element-desktop.package}/share/applications/element-desktop.desktop"
    ];
    stylix.targets.halloy.fonts.override = {
      sizes.applications = 15;
    };
    programs = {
      element-desktop = {
        # TODO configure this
        enable = true;
      };
      # For matrix
      halloy = {
        enable = true;
        settings = {
          servers.liberachat = {
            password_keyring = true;
            sasl = {
              plain = {
                username = "woodenAllen";
                password_keyring = true;
              };
            };
            server = "irc.libera.chat";
            use_tls = true;
            nickname = "woodenAllen";
            channels = [
              "##anime"
              "#archlinux"
              "#archlinux-offtopic"
              "##chat"
              "#gentoo"
              "#gentoo-chat"
              "#halloy"
            ];
          };
          notifications = {
            direct_message = {
              sound = "peck";
              show_toast = true;
            };
          };
        };
      };
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
            };
          };
        };
      };
    };
  };
}
