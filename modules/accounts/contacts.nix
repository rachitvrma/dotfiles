{
  flake.homeModules.contacts =
    {
      ...
    }:
    {
      # TODO: Configure the accounts module for it
      programs.khard = {
        enable = true;
      };
    };
}
