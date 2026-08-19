# use https://podcastindex.org/ to search for podcasts and their RSS feeds.
{
  flake.nixosModules.miniflux = {
    services.miniflux = {
      enable = true;
      adminCredentialsFile = "/etc/secrets/miniflux-admin-credentials";
    };
  };

  # TODO: Write the module for eilmeldung
  flake.homeModules.eilmeldung = { ... }: {
    programs.eilmeldung = {
      enable = true;
      settings = {
        mouse_support = true;

        feed_list = [
          "query: \"Marked\" marked"
          "query: \"Reviews\" #reviews"
          "feeds"
          "* categories"
          "tags"
        ];

        startup_commands = [ "sync" ];

        after_sync_commands = [
          "query lastsync"
          "tag rust title:\"rust\""
          "read title:/^Advertisement/"
          "refresh"
        ];

        video_enclosure_command = "mpv {url}";
        audio_enclosure_command = "vlc {url}";

        share_targets = [
          "clipboard"
          "feh feh \"{url}\""
        ];

        input_config.mappings = {
          "; i" = [ "cmd hintshare feh" ];
          "y" = [
            "confirm in articles read all"
            "nextunread"
          ];
        };
      };
    };
  };
}
