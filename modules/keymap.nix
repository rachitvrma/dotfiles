{
  flake.nixosModules.keymap = {
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
      # options = "ctrl:swapcaps";
      options = "caps:swapescape";
    };

    # also configure the console keymap
    console.keyMap = "mod-dh-ansi-us";
  };

  flake.homeModules.keymap = {
    home.keyboard = {
      layout = "us";
      options = [
        # "ctrl:swapcaps"
        "caps:swapescape"
      ];
      variant = "colemak_dh";
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/input-sources" = {
          xkb-options = [
            # "ctrl:swapcaps"
            "caps:swapescape"
          ];
        };
        "org/gnome/desktop/interface" = {
          # gtk-key-theme = "Emacs";
        };
      };
    };
  };
}
