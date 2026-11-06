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

    # NOTE: Sync it with the set-gtk-theme.sh script in scripts dir
    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/input-sources".xkb-options = [ "ctrl:swapcaps" ];
            "org/gtk/Settings/FileChooser".startup-mode = "cwd";
            "org/gnome/desktop/interface" = {
              # Emacs keybindings in GTK applications
              gtk-theme = "adw-gtk3";
              gtk-key-theme = "Emacs";
              color-scheme = "prefer-dark";
            };
          };
        }
      ];
    };
  };
}
