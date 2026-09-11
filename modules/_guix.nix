# NOTE: This is a tryout of the guix package manager

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
      publish = {
        # enable = true; # NOTE somehow the service fails, didn't bother to investigate
        extraArgs = [
          "--compression=zstd:6"
          "--discover=no"
        ];
      };
      extraArgs = [
        "--max-jobs=4"
        "--debug"
      ];

    };
  };
}
