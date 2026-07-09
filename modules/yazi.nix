{
  flake.nixosModules.yazi = {
    programs.yazi = {
      enable = true;
    };
  };

  flake.homeModules.yazi = {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
