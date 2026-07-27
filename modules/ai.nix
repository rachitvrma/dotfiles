{
  flake.homeModules.ai = {
    programs = {
      opencode = {
        enable = true;
        web = {
          enable = true;
        };
        tui = {
          theme = "system";
        };
      };
    };
  };
}
