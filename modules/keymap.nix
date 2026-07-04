{
  flake.nixosModules.keymap = {
    programs.dconf.profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/input-sources" = {
            xkb-options = [ "ctrl:swapcaps" ];
          };
        };
      }
    ];

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
      options = "ctrl:swapcaps";
    };

    # also configure the console keymap
    console.keyMap = "mod-dh-ansi-us";
  };

  flake.homeModules.keymap = {
    home.keyboard = {
      layout = "us";
      options = [
        "ctrl:swapcaps"
      ];
      variant = "colemak_dh";
    };
  };
}
