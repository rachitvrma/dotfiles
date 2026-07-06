{
  flake.nixosModules.xdg = {
    xdg = {
      icons = {
        enable = true;
      };
      mime.enable = true;
      menus.enable = true;
      sounds.enable = true;

      portal = {
        enable = true;
        xdgOpenUsePortal = true;
      };
    };
  };

  flake.homeModules.xdg = { config, pkgs, ... }: {
    home.preferXdgDirectories = true;
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplicationPackages = [
          config.programs.firefox.finalPackage # Covers html links
          config.programs.mpv.package # Covers audio/video
          config.programs.zathura.package # Covers pdfs and other kinda docs
          config.programs.swayimg.package # Covers images
        ];

        defaultApplications = {
          "image/jpeg" = "swayimg.desktop";
        };
      };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
      };

      userDirs = {
        enable = true;
        createDirectories = true;

        extraConfig = {
          MISC = "${config.home.homeDirectory}/Misc";
        };

        setSessionVariables = true;
      };
    };
  };
}
