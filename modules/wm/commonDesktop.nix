{
  flake.nixosModules.commonDesktop = { pkgs, ... }: {
    services = {
      udisks2.enable = true;
      gvfs.package = pkgs.gvfs.override { gnomeSupport = false; };
      gnome.gnome-keyring.enable = true;
      playerctld.enable = true;
    };

    security = {
      polkit.enable = true;
      pam.services = {
        greetd.enableGnomeKeyring = true;
      };
    };
  };

  flake.homeModules.commonDesktop = {
    xdg.portal.enable = true;
    programs = {
      swayimg = {
        enable = true;
        initLua = /* lua */ ''
          -- ~/.config/swayimg/init.lua

          -- Gruvbox Material Dark Hard base16 palette
          local bg      = 0xcc1d2021 -- base00, ~80% opacity for blur to show through
          local fg      = 0xffd4be98 -- base05
          local bg_alt  = 0xcc3c3836 -- base01, same alpha as bg
          local blue    = 0xff7daea3 -- base0D (secondary accent)
          local magenta = 0xffd3869b -- base0E (primary accent)

          -- General
          swayimg.set_mode("viewer")
          swayimg.enable_decoration(false)
          swayimg.enable_overlay(true)
          swayimg.enable_exif_orientation(true)
          swayimg.enable_antialiasing(true)

          -- Image list
          swayimg.imagelist.set_order("alpha")
          swayimg.imagelist.enable_reverse(false)

          -- Viewer mode colors
          swayimg.viewer.set_window_background(bg)
          swayimg.viewer.set_image_chessboard(20, bg, bg_alt)
          swayimg.viewer.set_default_scale("optimal")
          swayimg.viewer.set_default_position("center")

          -- Text/status overlay colors
          swayimg.text.set_foreground(fg)
          swayimg.text.set_background(0x00000000)  -- fully transparent, text floats over image

          -- Gallery mode colors
          swayimg.gallery.set_border_color(magenta)
          swayimg.gallery.set_selected_color(blue)
        '';
      };
    };
    services = {
      playerctld.enable = true;
      udiskie.enable = true;

      batsignal = {
        enable = true;
        extraArgs = [
          "-w"
          "40" # warning level
          "-c"
          "30" # critical level
          "-d"
          "20" # danger level
          "-f"
          "80" # full-battery notification (0 disables; 97-99 is the usual choice since some batteries never report exactly 100)
          "-m"
          "60" # min seconds between checks
        ];
      };
    };
  };
}
