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

    environment.localBinInPath = true;
  };

  flake.homeModules.xdg = { config, pkgs, ... }: {
    home.preferXdgDirectories = true;
    xdg = {
      enable = true;
      autostart.readOnly = true;
      localBinInPath = true;
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
          "video/*" = "mpv.desktop";
          "application/vnd.comicbook+zip" = "org.pwmt.zathura.desktop";
        };
      };
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [ pkgs.xdg-desktop-portal-termfilechooser ];
        config.common."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
      # Manages xdg-desktop-portal-termfilechooser
      configFile."xdg-desktop-portal-termfilechooser/config".text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        env=PATH="$PATH:/run/current-system/sw/bin"
        default_dir=$HOME
      '';
      userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig = {
          MISC = "${config.home.homeDirectory}/Misc";
          NOTES = "${config.home.homeDirectory}/Notes";
        };
        setSessionVariables = true;
      };
    };
  };
}
