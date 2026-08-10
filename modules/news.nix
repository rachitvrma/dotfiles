# use https://podcastindex.org/ to search for podcasts and their RSS feeds.
{ self, ... }:
{
  flake.nixosModules.miniflux = {
    services.miniflux = {
      enable = true;
      adminCredentialsFile = "/etc/secrets/miniflux-admin-credentials";
    };
  };

  # TODO: Write the module for eilmeldung
  flake.homeModules.eilmeldung = { pkgs, ... }: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.eilmeldung
    ];
  };
}
