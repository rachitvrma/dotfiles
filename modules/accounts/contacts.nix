{
  flake.homeModules.contacts =
    {
      ...
    }:
    {
      # TODO: Configure the accounts module for it
      programs.khard = {
        enable = true;
        settings = {
          general = {
            debug = false;
            default_action = "list";
            vim = [
              "vim"
              "-i"
              "NONE"
            ];
            merge_editor = "vimdiff";
          };
        };
      };

      accounts.contact.accounts.gmail.khard = {
        enable = true;
      };
    };
}
