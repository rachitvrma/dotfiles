{ inputs, ... }:
let
  commonStylix = pkgs: config: {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

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
        dark = "Gruvbox-Plus-Dark";
        light = config.stylix.icons.dark;
        package = pkgs.gruvbox-plus-icons.override {
          folder-color = "purple";
        };
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

      # Required for configuring extra fonts, like symbols-only-nerd font
      # Enabling this in nixosModules, automatically enables in home-manager.
      fonts = {
        # enableDefaultPackages = false;
        fontconfig = {
          enable = true;
        };
      };
    }
    // (commonStylix pkgs config);
  flake.homeModules.stylix = { config, pkgs, ... }: commonStylix pkgs config;
}
