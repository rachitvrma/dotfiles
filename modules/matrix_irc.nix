{
  flake.homeModules.matrix_irc = { pkgs, ... }: {
    home.packages = [ pkgs.irssi ];
    programs = {
      # element-desktop.enable = true;
      # TODO: Configure Irssi and then transfer stuff here.
      /*
        irssi = {
          enable = true;
        };
      */
      iamb = {
        enable = true;
        settings = {
          default_profile = "main";
          profiles.main = {
            user_id = "@rachitvrma:matrix.org";
            url = "https://matrix.org";
          };
        };
      };
    };
  };
}
