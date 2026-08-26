let
  shinchan =
    pkgs:
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Fastfetch/Shinchan.png";
      hash = "sha256-CP9uGyslZ19wCaglMb1UG+NmcU/GxN5HDXSdrO5jAlw=";
    };
in
{
  flake.nixosModules.noctalia = { pkgs, ... }: {
    programs = {
      noctalia = {
        enable = true;
        systemd.enable = true;
        recommendedServices.enable = true;
      };
    };
    services.displayManager.noctalia-greeter = {
      enable = true;
      cursorTheme = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
      };
      settings = {
        session.default = "niri";
        user.default = "krish";
        appearance = {
          scheme = "Synced";
          password_style = "random";
          hide_logo = false;
          theme_mode = "dark";
          corner_radius_scale = 2.0;
        };
        keyboard = {
          layout = "us";
          variant = "colemak_dh";
          options = "caps:swapescape";
          numlock = true;
        };
        auth = {
          allow_empty_password = false;
        };
      };
    };

    # For Avatar Image
    systemd.tmpfiles.rules = [
      "L+ /var/lib/AccountsService/icons/krish - - - - ${shinchan pkgs}"
      "f+ /var/lib/AccountsService/users/krish 0644 root root - [User]\\nIcon=/var/lib/AccountsService/icons/krish\\n"
    ];
  };

  # For modification see noctalia module in experimental modules
  flake.homeModules.noctalia = { pkgs, ... }: {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = import ./_hm-noctalia.nix { inherit shinchan pkgs; };
    };
  };
}
