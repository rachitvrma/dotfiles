{
  flake.nixosModules.theme = {
    gtk.iconCache.enable = true;
  };

  flake.homeModules.theme = { pkgs, config, ... }: {
    home = {
      pointerCursor = {
        dotIcons = {
          enable = true;
        };
        enable = true;
        gtk = {
          enable = true;
        };
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        x11 = {
          defaultCursor = "phinger-cursors-light";
          enable = true;
        };
      };
    };

    gtk =
      let
        extraConfig = {
          gtk-recent-files-limit = 20;
          gtk-key-theme-name = "Emacs";
        };
      in
      {
        theme = {
          package = pkgs.gruvbox-gtk-theme.override {
            colorVariants = [ "dark" ];
            sizeVariants = [ "standard" ];
            themeVariants = [ "pink" ];
            tweakVariants = [
              "macos"
              "medium"
            ];
            iconVariants = [ "Dark" ];
          };
          name = "Gruvbox-Pink-Dark-Medium";
        };
	colorScheme = "dark";
        gtk4 = {
          enable = true;
          theme = config.gtk.theme;
          inherit extraConfig;
	};
	gtk3 = {
	  enable = true;
	  theme = config.gtk.theme;
	  inherit extraConfig;
	};

        font = {
          name = "JetBrainsMono Nerd Font Mono";
          size = 11;
          package = pkgs.nerd-fonts.jetbrains-mono;
        };

        enable = true;

        iconTheme = {
          package = pkgs.gruvbox-plus-icons.override { folder-color = "violet"; };
          name = "Gruvbox-Plus-Dark";
        };
      };
  };
}
