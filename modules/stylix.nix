{ inputs, ... }: {
  flake.nixosModules.stylix = { pkgs, config, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    gtk.iconCache.enable = true;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      override = {
        base00 = "141617";
      };

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Gruvbox/castle.jpg";
        hash = "sha256-OHRzLcnenyZvQ0Q3pRx/tM5PBKw0hta+/YTo37tXRKc=";
      };

      polarity = "dark";

      cursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 32;
      };

      icons = {
        dark = "Gruvbox-Plus-Dark";
        light = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons.override { folder-color = "violet"; };
      };

      fonts = {
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = config.stylix.fonts.serif;
        monospace = config.stylix.fonts.serif;
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      opacity = rec {
        desktop = 0.8;
        applications = desktop;
        popups = desktop;
        terminal = 0.9;
      };
      overlays.enable = true;
    };
  };
  flake.homeModules.stylix = { pkgs, config, ... }: {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

      targets.cava.rainbow.enable = true;

      override = {
        base00 = "141617";
      };

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Gruvbox/castle.jpg";
        hash = "sha256-OHRzLcnenyZvQ0Q3pRx/tM5PBKw0hta+/YTo37tXRKc=";
      };

      polarity = "dark";

      cursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 32;
      };

      icons = {
        dark = "Gruvbox-Plus-Dark";
        light = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons.override { folder-color = "violet"; };
      };

      fonts = {
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = config.stylix.fonts.serif;
        monospace = config.stylix.fonts.serif;
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
