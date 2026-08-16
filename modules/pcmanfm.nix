{
  flake.nixosModules.pcmanfm = { pkgs, ... }: {
    services = {
      udisks2.enable = true;
      gvfs = {
        enable = true;
      };
      gnome.gnome-keyring.enable = true;
      playerctld.enable = true;
      devmon.enable = true;
    };
    environment.systemPackages = with pkgs; [
      pcmanfm
      lxmenu-data
      shared-mime-info
    ];
  };
}
