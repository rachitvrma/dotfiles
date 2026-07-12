{
  flake.homeModules.matrix = {
    programs = {
      # element-desktop.enable = true;
      iamb = {
        enable = true;
        settings = {
          profiles.main.user_id = "@rachitvrma:matrix.org";
          settings.default_profile = "main";
        };
      };
    };
  };
}
