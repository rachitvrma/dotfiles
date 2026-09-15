{
  flake.nixosModules.noctalia =
    { ... }:
    {
      programs.noctalia = {
        enable = true;
        systemd.enable = true;
        recommendedServices.enable = true;
      };
    };
  flake.homeModules.noctalia = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      # For external monitors, if the need ever arises
      ddcutil
      ddcutil-service
      ddcui
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = lib.importTOML ./noctalia.toml;
    };
  };
}
