{
  flake.nixosModules.secret-services = {
    services = {
      gnome.gnome-keyring.enable = true;
    };
    programs.seahorse.enable = true;
  };
  flake.homeModules.secret-services = {
    services.gnome-keyring.enable = true;
  };
}
