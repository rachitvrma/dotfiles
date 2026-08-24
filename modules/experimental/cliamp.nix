{
  flake.homeModules.cliamp-module =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.cliamp;
      tomlFormat = pkgs.formats.toml { };
      inherit (lib)
        mkIf
        mkEnableOption
        mkPackageOption
        mkOption
        types
        ;
    in
    {
      meta.maintainers = [ lib.maintainers.rachitvrma ];

      options.programs.cliamp = {
        enable = mkEnableOption "cliamp, a retro terminal music player inspired by Winamp";
        package = mkPackageOption pkgs "cliamp" { nullable = true; };
        settings = mkOption {
          inherit (tomlFormat) type;
          default = { };
          example = {
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
            theme = "";
            visualizer = "Bricks";
            ytmusic = {
              enabled = true;
            };
          };

          description = ''
            Configuration written to
            {file}`$XDG_CONFIG_HOME/cliamp/config.toml`.

            See
            <https://whiterose.org.contextowl.co/docs/cliamp>
            for the full list of options.
          '';
        };
        themes = mkOption {
          type = types.attrsOf (
            types.oneOf [
              tomlFormat.type
            ]
          );
          default = { };
          example = {
            solarized = {
              accent = "#268bd2";
              bright_fg = "#eee8d5";
              fg = "#839496";
              green = "#859900";
              yellow = "#b58900";
              red = "#dc322f";
            };
          };
          description = ''
            Each theme is written to {file}`$XDG_CONFIG_HOME/cliamp/themes/NAME.toml`.
            See <https://whiterose.org.contextowl.co/docs/cliamp/themes> for more information.
          '';
        };
        radios = mkOption {
          inherit (tomlFormat) type;
          default = { };
          example = ''
            station = [
              {
                name = "Jazz FR";
                url = "https://jazz.example.com/stream";
              }
              {
                name = "Ambient Radio";
                url = "https://ambient.example.com/stream.m3u";
              }
            ];
          '';
          description = ''
            Add your own stations to {file}`$XDG_CONFIG_HOME/cliamp/radios.toml`.
            See <https://github.com/bjarneo/cliamp/blob/main/docs/configuration.md#custom-radio-stations>
          '';
        };
      };
      config = mkIf cfg.enable {
        home.packages = mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile = lib.mkMerge [
          {
            "cliamp/config.toml" = mkIf (cfg.settings != { }) {
              source = tomlFormat.generate "cliamp-config" cfg.settings;
            };
          }
          {
            "cliamp/radios.toml" = mkIf (cfg.radios != { }) {
              source = tomlFormat.generate "cliamp-radios" cfg.radios;
            };
          }
          (lib.mapAttrs' (
            name: value:
            lib.nameValuePair "cliamp/themes/${name}.toml" {
              source = tomlFormat.generate "cliamp-theme-${name}" value;
            }
          ) cfg.themes)
        ];
      };
    };
}
