{
  flake.homeModules.xplr = {
    programs.xplr = {
      enable = true;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}
