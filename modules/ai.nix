{
  flake.homeModules.ai = {
    programs = {
      opencode = {
        enable = true;
        web = {
          enable = true;
        };
      };
    };

    services = {
      ollama = {
        enable = true;
      };
    };
  };
}
