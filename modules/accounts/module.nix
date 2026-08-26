{
  flake.homeModules.accounts = { config, ... }: {
    accounts.contact.basePath = config.home.homeDirectory + "/.contacts";
  };
}
