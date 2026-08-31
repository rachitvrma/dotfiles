{
  flake.homeModules.cliamp = { config, pkgs, ... }: {
    home.sessionVariables = {
      CLIAMP_YTMUSIC_CLIENT_ID = "$(cat ${config.age.secrets.ytmusic-client-id.path})";
      CLIAMP_YTMUSIC_CLIENT_SECRET = "$(cat ${config.age.secrets.ytmusic-client-secret.path})";
    };
    programs.cliamp = {
      enable = true;
      settings = {
        eq = [
          "-2"
          "0"
          "0"
          "0"
          "0"
          "0"
          "0"
          "0"
          "0"
          "0"
        ];
        eq_preset = "Custom";
        theme = "stylix";
        visualizer = "block-burst"; # This is from the plugin
        provider = "ytmusic";
        ytmusic = {
          enabled = true;
          cookies_from = "firefox";
          client_id = "\${CLIAMP_YTMUSIC_CLIENT_ID}";
          client_secret = "\${CLIAMP_YTMUSIC_CLIENT_SECRET}";
        };
        soundcloud = {
          enabled = true;
          user = "woodenAllen";
          cookies_from = "firefox";
        };
        volume = 0;
        repeat = "Off";
        shuffle = false;
        initial_directory = "~/Music";
        low_power = false;
      };
      radios = {
        station = [
          {
            name = "Jazz FM";
            url = "https://jazz.example.com/stream";
          }
          {
            name = "Ambient Radio";
            url = "https://ambient.example.com/stream.m3u";
          }
        ];
      };
      themes = {
        stylix = with config.lib.stylix.colors.withHashtag; {
          bg = base00;
          accent = base0D;
          bright_fg = base05;
          fg = base0C;
          green = base0B;
          yellow = base0A;
          red = base08;
        };
      };
      systemd = {
        enable = true;
        extraFlags = [
          "--auto-play"
          "%h/Music"
        ];
      };
      plugins = {
        block-burst = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/AlexZeitler/cliamp-plugin-block-burst/master/block-burst.lua";
          hash = "sha256-CK/NlavSzePrOFop6tGLbp5S0aTokb6ZcDNxpvzsxxo=";
        };
      };
    };
  };
}
