{
  flake.homeModules.impala =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.programs.impala;
      tomlFormat = pkgs.formats.toml { };
      inherit (lib)
        mkEnableOption
        mkPackageOption
        mkOption
        mkIf
        ;
    in
    {
      options.programs.impala = {
        enable = mkEnableOption "impala, a TUI for iwd network";
        package = mkPackageOption pkgs "impala" { nullable = true; };
        settings = mkOption {
          inherit (tomlFormat) type;
          default = { };
        };
      };

      config = mkIf cfg.enable {
        home.packages = mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."impala/config.toml" = mkIf (cfg.settings != { }) {
          source = tomlFormat.generate "hm_impala-config.toml" cfg.settings;
        };
      };
    };
}
