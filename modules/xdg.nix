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

    environment = {
      localBinInPath = true;
      pathsToLink = [
        "/share/xdg-desktop-portal"
        "/share/applications"
      ];
    };
  };
}


