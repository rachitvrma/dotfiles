{ inputs, ... }:
let
  commonStylix = pkgs: config: {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";

      /*
        image = pkgs.fetchurl {
          url = "";
          hash = "";
        };
      */

      polarity = "dark";

      cursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 32;
      };

      icons = {
        enable = true;
        dark = "Papirus-Dark";
        light = config.stylix.icons.dark;
        package = pkgs.papirus-icon-theme.override {
          color = "magenta";
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
    };
  };
in
{
  flake.nixosModules.stylix =
    { pkgs, config, ... }:
    {
      imports = [ inputs.stylix.nixosModules.stylix ];
      gtk.iconCache.enable = true;
      stylix.overlays.enable = true; # This is a NixOS only option
    }
    // (commonStylix pkgs config);
  flake.homeModules.stylix = { config, pkgs, ... }: commonStylix pkgs config;
}
