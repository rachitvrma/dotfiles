{
  flake.homeModules.matrix_irc = { config, ... }: {
    stylix.targets.halloy.fonts.override = {
      sizes.applications = 14;
    };
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
          servers = {
            Libera = {
              channels = [
                # Interests
                "##anime"
                "#reading"
                "#writers"
                "#books"

                # Operating Systems & Core Distributions
                "#linux"
                "#gnu"
                "#nixos"
                "#nixos-dev"
                "#nixos-chat"
                "#home-manager"
                "#debian"
                "#fedora"
                "#rhel"
                "#gentoo"
                "#gentoo-chat"
                "#gentoo-ops"
                "#freebsd"
                "#openbsd"
                "#netbsd"

                # Editors, Terminals & User Interfaces
                "#vim"
                "#neovim"
                "#neovim-chat"
                "#neovim-dev"
                "#halloy"
                "#mpv"
                "#firefox"

                # Shells, Scripting & System Tooling
                "#bash"
                "#zsh"
                "#systemd"
                "#btrfs"
                "#jujutsu"
                "#git"
                "#taskwarrior"

                # Programming Languages & Low-Level Development
                "#c"
                "#C++"
                "#java"
                "#lua"
                "#algorithms"
                "#osdev"
                "#kernel"

                # Infrastructure, Security & Networking
                "#security"
                "#networking"
                "#postgresql"

                # General & Theoretical Sciences
                "##programming"
                "##math"
                "##physics"
                "#philosophy"
                "##chat"
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
            Hackint = {
              nickname = "woodenAllen";
              server = "irc.hackint.org";
              use_tls = true;
              channels = [
                "#nixos"
                "#sway"
              ];
              # sasl.plain = {
              #   username = "woodenAllen";
              #   # Create {file}`~/.config/halloy/matrix_password`, put the correct password, and then
              #   # change the permission to 0600 using `chmod 0600 ~/.config/halloy/irc_password`
              #   password_file = "${config.xdg.configHome}/halloy/irc_password";
              # };
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
