{
  flake.homeModules.stylua-module =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.programs.stylua;
      inherit (lib)
        mkEnableOption
        mkOption
        mkPackageOption
        mkIf
        ;

      tomlFormat = pkgs.formats.toml { };
    in
    {
      options.programs.stylua = {
        enable = mkEnableOption "stylua, a formatter for lua files";
        package = mkPackageOption pkgs "stylua" { nullable = true; };
        settings = mkOption {
          inherit (tomlFormat) type;
          default = { };
        };
      };

      config = mkIf cfg.enable {
        home.packages = mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."stylua/stylua.toml" = mkIf (cfg.settings != { }) {
          source = tomlFormat.generate "hm_stylua.toml" cfg.settings;
        };
      };
    };
}
