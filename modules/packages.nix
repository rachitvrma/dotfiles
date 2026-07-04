{
  flake.nixosModules.packages = { pkgs, ... }: {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
    ];

    services = {
      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;
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
    programs.gcc.enable = true;

    home.packages = with pkgs; [
      gitingest
      wl-clipboard
    ];
  };
}
