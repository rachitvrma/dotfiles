# NOTE: Himalaya's new modules are in PR.
# https://github.com/nix-community/home-manager/pull/9794
# TODO: Also make a PR for ortie, pimalaya's own OAuth agent
{
  flake.homeModules.email = { pkgs, ... }: {

    programs = {
      password-store = {
        enable = true;
        package = pkgs.pass-wayland;
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
        flavor = "gmail.com";
        # TODO: Package pimalaya's orties auth tool, and move to it
        passwordCommand = "pass show email/gmail";
        himalaya = {
          enable = true;
          settings.pgp.type = "gpg";
        };
      };
    };
  };
}
