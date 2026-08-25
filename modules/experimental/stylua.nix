{
  flake.homeModules.stylua-module =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      cfg = config.programs.stylua;
      inherit (lib)
        mkOption
        mkEnableOption
        mkPackageOption
        mkIf
        types
        ;
      tomlFormat = pkgs.formats.toml { };
    in
    {
      meta.maintainers = [ lib.maintainers.rachitvrma ];

      options.programs.stylua = {
        enable = mkEnableOption "stylua, a formatter for lua";
        package = mkPackageOption pkgs "stylua" { };
        finalPackage = mkOption {
          readOnly = true;
          visible = false;
          type = types.package;
          description = "Resulting Package";
        };
        settings = mkOption {
          inherit (tomlFormat) type;
          default = { };
          example = {
            call_parentheses = "Always";
            collapse_simple_statement = "Always";
            column_width = 85;
            indent_type = "Spaces";
            indent_width = 2;
            line_endings = "Unix";
            quote_style = "AutoPreferSingle";
          };
          description = ''
            Configuration options that are written to {file}`XDG_CONFIG_HOME/stylua/stylua.toml`

            See <https://github.com/JohnnyMorganz/StyLua#options> for more options.
          '';
        };
      };

      config = mkIf cfg.enable {
        home.packages = [ cfg.finalPackage ];

        programs.stylua.finalPackage = pkgs.symlinkJoin {
          name = "stylua-wrapped";
          paths = [ cfg.package ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/stylua \
            --add-flags '--config-path ${config.xdg.configHome}/stylua/stylua.toml'
          '';
        };

        xdg.configFile."stylua/stylua.toml" = mkIf (cfg.settings != { }) {
          source = tomlFormat.generate "hm_stylua.toml" cfg.settings;
        };
      };
    };
}
