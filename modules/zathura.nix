{
  flake.homeModules.zathura = {
    programs.zathura = {
      enable = true;
      options = {
        font = "monospace normal 11";
      };
    };
  };
}
