{
  flake.nixosModules.pass = { ... }: {
    services.passSecretService.enable = true;
  };
  flake.homeModules.email = { pkgs, ... }: {
    services.pass-secret-service = {
      enable = true;
    };
    home.packages = with pkgs; [
      # Used in image rendering in aerc
      chafa
      libnotify # For notification in aerc
      gcalcli # google calendar cli
    ];
    programs = {
      aerc = {
        enable = true;

        extraConfig = {
          # NOTE: There's a whole warning about it, please read it.
          general.unsafe-accounts-conf = true;

          ui = {
            sort = "-r date";
          };

          filters = {
            "text/html" = "! w3m -I UTF-8 -T text/html"; # Taken from
            "text/plain" = "colorize"; # https://aerc-docs.com/ecosystem/w3m/
            # Image preview
            "image/*" = "chafa -f kitty -s $(tput cols)x$(tput lines) -";
          };
          hooks = {
            mail-received = ''notify-send "New mail from $AERC_FROM_NAME" "$AERC_SUBJECT"'';
          };
          openers = {
            "image/*" = "xdg-open {}";
          };
        };
      };
      password-store = {
        enable = true;
        package = pkgs.pass-wayland;
      };
    };
    accounts = {
      email.accounts.Personal = {
        realName = "Rachit Kumar Verma";
        address = "rachitverma1122@gmail.com";
        primary = true;
        flavor = "gmail.com";
        # TODO: Package pimalaya's orties auth tool, and move to it
        passwordCommand = "pass show email/gmail";
        aerc = {
          enable = true;
        };
      };
    };
  };
}
