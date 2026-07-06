{
  flake.nixosModules.packages = { pkgs, ... }: {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
    ];

    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
    };

    security = {
      sudo = {
        enable = true;
        execWheelOnly = true;
        package = pkgs.sudo.override {
          withInsults = true;
        };

        extraConfig =
          # bash
          ''
            Defaults pwfeedback
          '';
      };
    };
  };

  flake.homeModules.packages = { pkgs, ... }: {
    programs = {
      pandoc.enable = true;
      atool = {
        enable = true;
        extraPackages = with pkgs; [
          bzip2
          cpio
          gnutar
          gzip
          lhasa
          lzop
          p7zip
          unrar-free
          unzip
          xz
          zip
        ];
        settings = {
          path_unrar = "unrar-free";
        };
      };
      bottom = {
        enable = true;
        settings = {
          styles.theme = "gruvbox";
        };
      };
      gcc.enable = true;
      # TODO: Make a module for $XDG_CONFIG_HOME/cava/themes
      cava = {
        enable = true;
        settings = {
          general = {
            live-config = 1;
          };
          input = {
            method = "pipewire";
          };
          smoothing = {
            monstercat = 1;
            waves = 1;
            noise_reduction = 77;
          };
          color = {
            background = "'#141617'";
            foreground = "'#ddc7a1'";
            gradient = 1;
            gradient_color_1 = "'#ea6962'";
            gradient_color_2 = "'#e78a4e'";
            gradient_color_3 = "'#d8a657'";
            horizontal_gradient = 1;
            horizontal_gradient_color_1 = "'#a9b665'";
            horizontal_gradient_color_2 = "'#7daea3'";
            horizontal_gradient_color_3 = "'#d3869b'";
            blend_direction = "up";
          };
        };
      };
    };

    home.packages = with pkgs; [
      gitingest
      wl-clipboard
      unzip
    ];
  };
}
