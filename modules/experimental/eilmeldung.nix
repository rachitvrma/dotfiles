{
  flake.homeModules.eilmeldung-module =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.programs.eilmeldung;
      tomlFormat = pkgs.formats.toml { };
    in
    {
      options.programs.eilmeldung = {
        enable = lib.mkEnableOption "eilmeldung, a TUI news feed reader";

        package = lib.mkPackageOption pkgs "eilmeldung" { nullable = true; };

        settings = lib.mkOption {
          inherit (tomlFormat) type;
          default = { };
          example = lib.literalExpression ''
            {
              refresh_fps = 60;
              article_scope = "unread";
              read_icon = "󰄬";
              unread_icon = "󰄱";

              theme = {
                color_palette = {
                  background = "#1e1e2e";
                  foreground = "#cdd6f4";
                  accent_primary = "#f5c2e7";
                };
              };

              input_config = {
                scroll_amount = 10;
                mappings = {
                  "q" = "quit";
                  "j" = "down";
                  "k" = "up";
                };
              };
            }
          '';
          description = ''
            Configuration written to
            {file}`$XDG_CONFIG_HOME/eilmeldung/config.toml`.

            See <https://github.com/christo-auer/eilmeldung/blob/main/docs/configuration.md>
            for the full list of options.
          '';
        };
      };
      config = lib.mkIf cfg.enable {
        home.packages = lib.mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."eilmeldung/config.toml" = lib.mkIf (cfg.settings != { }) {
          source = tomlFormat.generate "eilmeldung-config.toml" cfg.settings;
        };
      };
    };
}
