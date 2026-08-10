{
  flake.homeModules.email = {
    programs = {
      password-store = {
        enable = true;
      };
      himalaya = {
        enable = true;
        settings = { };
      };
    };

    accounts = {
      email.accounts.gmail = {
        realName = "Rachit Kumar Verma";
        address = "rachitverma1122@gmail.com";
        primary = true;
        himalaya = {
          enable = true;
        };
      };
    };
  };
}
