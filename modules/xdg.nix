{
  flake.nixosModules.xdg = { pkgs, ... }: {
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
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
        ];
        configPackages = [
          pkgs.gnome-session
        ];
      };
    };
  };

  flake.homeModules.xdg = { config, pkgs, ... }: {
    home.preferXdgDirectories = true;
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.enable = true;

      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
        ];
        configPackages = [
          pkgs.gnome-session
        ];
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
