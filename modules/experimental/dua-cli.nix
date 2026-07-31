{
  flake.homeModules.dua-cli-module =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.programs.dua-cli;
      tomlFormat = pkgs.formats.toml { };
    in
    {
      options.programs.dua-cli = {
        enable = lib.mkEnableOption "dua-cli";

        package = lib.mkPackageOption pkgs "dua" { nullable = true; };

        settings = lib.mkOption {
          inherit (tomlFormat) type;

          default = { };

          example = lib.literalExpression /* toml */ ''
            [keys]
            # If true, pressing <Esc> in the main pane navigates to the parent directory.
            # If true (default), pressing <Esc> in the main pane ascends to the parent directory.
            # If false, <Esc> follows the default quit behavior.
            esc_navigates_back = true
          '';
        };
      };
      config = lib.mkIf cfg.enable {
        home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."dua-cli/config.toml" = lib.mkIf (cfg.settings != { }) {
          source = tomlFormat.generate "hm_dua-cli_config" cfg.settings;
        };
      };
    };
  flake.homeModules.dua-cli = {
    programs.dua-cli = {
      enable = true;
      settings = {
        keys.esc_navigates_back = true;
      };
    };
  };
}
