{
  flake.nixosModules.hyprland = { pkgs, config, ... }: {
    programs = {
      uwsm = {
        enable = true;
      };
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = false;
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      # I am guessing it's configured by default
      configPackages = [
        config.programs.hyprland.package
      ];
    };
  };

  flake.homeModules.hyprland =
    {
      pkgs,
      config,
      ...
    }:
    {
      xdg = {
        portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
          ];
        };
        configFile."uwsm/env".source =
          "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
      };

      home = {
        pointerCursor.hyprcursor.enable = true;
        packages = with pkgs; [
          hyprshutdown
          brightnessctl
          kitty
          trash-cli
        ];
      };
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = false;
        systemd.enable = false;

        extraConfig = builtins.readFile ./hyprland.lua;
      };

      services = {
        hyprpolkitagent.enable = true;
      };
    };
}
