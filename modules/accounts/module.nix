{
  flake.homeModules.email = { pkgs, ... }: {
    programs = {
      ripasso = {
        enable = true;
        settings = {
          stores.default = {
            path = "/home/krish/.password-store";
            pgp_implementation = "gpg";
          };
        };
      };
      password-store = {
        enable = true;
        package = pkgs.pass-wayland;
      };
    };
    accounts = {
      email.accounts.Personal = {
        realName = "Rachit Kumar Verma";
        address = "rachitverma1122@gmail.com";
        primary = true;
        flavor = "gmail.com";
        # TODO: Package pimalaya's orties auth tool, and move to it
        passwordCommand = "pass show email/gmail";
      };
    };
  };
}
