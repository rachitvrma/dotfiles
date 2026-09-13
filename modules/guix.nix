{
  flake.nixosModules.guix = { ... }: {
    services.guix = {
      enable = true;

      gc = {
        enable = true;
        extraArgs = [
          "--delete-generations=1m"
          "--free-space=10G"
          "--optimize"
        ];
        dates = "weekly";
      };

      extraArgs = [
        "--max-jobs=4"
        "--debug"
      ];

      # This is a non-default
      stateDir = "/gnu/var";
    };
  };
}
