{
  flake.nixosModules.guix = {
    services.guix = {
      enable = true;
      extraArgs = [
        "--max-jobs=1"
        "--cores=3"
        "--debug"
      ];
      gc = {
        enable = true;
        dates = "daily";
        extraArgs = [
          "--delete-generations=1m"
          "--free-space=10G"
          "--optimize"
        ];
      };
    };
  };
}
