{
  flake.nixosModules.pcmanfm = { pkgs, ... }: {
    services = {
      udisks2.enable = true;
      gvfs = {
        enable = true;
      };
      # I am using pass-secret-service already
      # gnome.gnome-keyring.enable = true;
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
