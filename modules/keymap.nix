{
  flake.nixosModules.keymap = {
    # Keymap in X11 / Wayland compositors
    services.xserver.xkb = {
      layout = "us";
      variant = "colemak_dh";
      options = "ctrl:swapcaps";
    };

    # Console keymap
    console.keyMap = "mod-dh-ansi-us";

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/input-sources".xkb-options = [ "ctrl:swapcaps" ];
            "org/gnome/desktop/interface" = {
              # Emacs keybindings in GTK applications
              gtk-key-theme = "Emacs";
              color-scheme = "prefer-dark";
            };
          };
        }
      ];
    };
  };
}
