{
  flake.nixosModules.packages = { pkgs, lib, ... }: {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment = {
      systemPackages = with pkgs; [
        wget
      ];
      sessionVariables = {
        SUDO_PROMPT = lib.concatStrings [
          " "
          "$(tput setaf 5 bold)[sudo]"
          "$(tput sgr0) $(tput setaf 6)password for"
          "$(tput sgr0) $(tput setaf 5)%p"
          "$(tput sgr0): "
        ];
      };
    };

    programs.appimage = {
      enable = true;
      binfmt = true;
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

      # Popular system monitors for the terminal
      bottom = {
        enable = true;
      };
      htop.enable = true;

      gcc.enable = true;
      # TODO: Make a module for $XDG_CONFIG_HOME/cava/themes
      # NOTE: For cava enabled the stylix.cava.rainbow.enable
      cava = {
        enable = true;
        settings = {
          general = {
            live-config = 1;
            framerate = 60;
            sensitivity = 100;
            lower_cutoff_freq = 50;
            higher_cutoff_freq = 1000;
          };
          input = {
            method = "pipewire";
          };
          smoothing = {
            monstercat = 1;
            waves = 1;
            noise_reduction = 77;
          };
        };
      };

      onlyoffice = {
        enable = true;
        settings = {
          UITheme = "theme-dark";
          titlebar = "custom";
          maximized = true;
          editorWindowMode = false;
          forcedRtl = false;
        };
      };
    };

    home.packages = with pkgs; [
      gitingest
      wl-clipboard
      unzip
      kotatogram-desktop
    ];
  };
}
