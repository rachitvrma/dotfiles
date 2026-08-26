{
  flake.nixosModules.networking = { pkgs, ... }: {
    # Enable networking
    networking = {
      networkmanager = {
        enable = true;
        wifi = {
          powersave = true;
          /*
            This option automatically configures
            and enables iwd. So, iwd doesn't need to
            enabled separately.
          */
          backend = "iwd";
        };
      };
      nftables.enable = true;
      firewall = {
        enable = true;
        allowedTCPPorts = [
          80
          443
        ];
        allowedUDPPortRanges = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
      };
    };

    # Control iwd from the terminal
    # environment.systemPackages = [ pkgs.impala ];
  };
}
