{ me, ... }:
{
  flake.nixosModules.desktop =
    { config, pkgs, ... }:
    let
      avatar = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitvrma/rachitvrma/main/.github/assets/shinchan.png";
        hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
      };
    in
    {
      programs = {
        umbriel.enable = true;
        noctalia = {
          enable = true;
          systemd.enable = false; # Start it using umbriel's autostart option
          recommendedServices.enable = true;
        };
      };

      services = {
        seatd.enable = true;
        accounts-daemon.enable = true;
        gnome.gnome-keyring.enable = true;
        xserver.updateDbusEnvironment = true;
        gvfs.enable = true;
        playerctld.enable = true;
        # Auto-mounting is done by the udiskie user service (services-user.nix).
        udisks2.enable = true;

        displayManager.noctalia-greeter = {
          enable = true;
          passwordlessSyncUsers = [ me.username ];
          cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
          };
          settings = {
            cursor = {
              size = 24;
              theme = "Bibata-Modern-Ice";
            };
            keyboard = {
              inherit (config.services.xserver.xkb) layout variant options;
              numlock = true;
            };
            user.default = me.username;
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
      };

      xdg.portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal-umbriel
        ];
        configPackages = [ config.programs.umbriel.package ];
      };

      security = {
        polkit.enable = true;
        pam.services = {
          greetd.enableGnomeKeyring = true;
          login.enableGnomeKeyring = true;
        };
      };

      # Login-screen avatar
      systemd.tmpfiles.rules = [
        "L+ /var/lib/AccountsService/icons/${me.username} - - - - ${avatar}"
        "f+ /var/lib/AccountsService/users/${me.username} 0644 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${me.username}\\n"
      ];
    };
}
