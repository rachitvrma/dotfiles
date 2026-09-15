{
  flake.nixosModules.umbriel = {
    programs.umbriel.enable = true;
  };
  flake.homeModules.umbriel = { pkgs, lib, ... }: {
    xdg = {
      portal = {
        extraPortals = with pkgs; [
          xdg-desktop-portal-umbriel
        ];
        configPackages = [ pkgs.umbriel ];
      };
    };
    # Pinentry-Egui is the package that works best with window managers
    services.gpg-agent.pinentry = {
      package = pkgs.pinentry-egui;
    };
    wayland.windowManager.umbriel = {
      enable = true;
      settings = lib.importTOML ./umbriel.toml;
    };
  };
}
