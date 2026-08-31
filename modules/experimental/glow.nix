{
  flake.homeModules.glow-module =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.programs.glow;
      yamlFormat = pkgs.formats.yaml { };
      jsonFormat = pkgs.formats.json { };
      inherit (lib)
        mkEnableOption
        mkPackageOption
        mkOption
        mkIf
        mkMerge
        types
        mapAttrs'
        ;
    in
    {
      meta.maintainers = [ lib.maintainers.rachitvrma ];

      options.programs.glow = {
        enable = mkEnableOption "glow, a TUI markdown renderer";
        package = mkPackageOption pkgs "glow" { nullable = true; };
        settings = mkOption {
          inherit (yamlFormat) type;
          default = { };
          example = {
            style = "auto";
            mosue = false;
            pager = false;
            width = 80;
            all = false;
          };
          description = ''
            Settings to write to the {file}`XDG_CONFIG_HOME/glow/glow.yml`.

            See <https://github.com/charmbracelet/glow#the-config-file>.
          '';
        };

        styles = mkOption {
          type = types.attrsOf jsonFormat.type;
          default = { };
          example = {
            default = {
              document = {
                block_prefix = "\n";
                block_suffix = "\n";
                color = "252";
                margin = 2;
              };
              block_quote = {
                indent = 1;
                indent_token = "│ ";
              };
              paragraph = { };
              list = {
                level_indent = 2;
              };
              heading = {
                block_suffix = "\n";
                color = "39";
                bold = true;
              };
              h1 = {
                prefix = " ";
                suffix = " ";
                color = "228";
                background_color = "63";
                bold = true;
              };
            };
          };
          description = ''
            Styles written to {file}`XDG_CONFIG_HOME/glow/styles/<name>.json`.
            To use any custom style pass the full path of style in the {file}`glow.yml`
            file or use the `--styles`/`-s` flag in the cli.

            See <https://github.com/charmbracelet/glow#styles> for more details.
          '';
        };
      };
      config = mkIf cfg.enable {
        home.packages = mkIf (cfg.package != null) [ cfg.package ];
        xdg.configFile = mkMerge [
          {
            "glow/glow.yml" = mkIf (cfg.settings != { }) {
              source = yamlFormat.generate "hm_glow.yml" cfg.settings;
            };
          }
          (mapAttrs' (
            name: value:
            lib.nameValuePair "glow/styles/${name}.json" {
              source = jsonFormat.generate "glow-${name}-style" value;
            }
          ) cfg.styles)
        ];
      };
    };
}
