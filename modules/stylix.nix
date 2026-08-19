{ inputs, ... }: {
  flake.nixosModules.stylix = { pkgs, config, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];
    gtk.iconCache.enable = true;

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Catppuccin/catppuccin-13.png";
        hash = "sha256-fYMzoY3un4qGOSR4DMqVUAFmGGil+wUze31rLLrjcAc=";
      };

      polarity = "dark";

      cursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 32;
      };

      icons = {
        enable = true;
        dark = "Gruvbox-Plus-Dark";
        light = config.stylix.icons.dark;
        package = pkgs.gruvbox-plus-icons.override {
          folder-color = "violet";
        };
      };

      fonts = {
        serif = {
          package = pkgs.maple-mono.NF;
          name = "Maple Mono NF";
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
  flake.homeModules.stylix = { config, pkgs, ... }: {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rachitvrma/Wallpapers/main/Catppuccin/wallhaven-yqg6r7_1920x1080.png";
        hash = "sha256-KRdrPEiFZwjAEWcEuNoKy8p07E0WdmooNPLhTg9ZtKo=";
      };
      targets = {
        cava.rainbow.enable = true;
        qt.standardDialogs = "xdgdesktopportal";
      };
      polarity = "dark";

      cursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 32;
      };

      icons = {
        enable = true;
        dark = "Gruvbox-Plus-Dark";
        light = config.stylix.icons.dark;
        package = pkgs.gruvbox-plus-icons.override {
          folder-color = "violet";
        };
      };

      fonts = {
        serif = {
          package = pkgs.maple-mono.NF;
          name = "Maple Mono NF";
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
        terminal = 0.85;
      };
    };
  };
}
