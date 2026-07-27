{
  flake.homeModules.pomo-module =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib)
        mkIf
        mkEnableOption
        mkOption
        mkPackageOption
        ;
      cfg = config.programs.pomo;
      yamlFormat = pkgs.formats.yaml { };
    in
    {
      options.programs.pomo = {
        enable = mkEnableOption "pomo";

        package = mkPackageOption pkgs "pomo" { nullable = true; };

        settings = mkOption {
          inherit (yamlFormat) type;

          default = { };
          defaultText = lib.literalExpression "{ }";

          example = lib.literalExpression ''
            {
              onSessionEnd = "ask";

              asciiArt = {
                enabled = true;
                font = "mono12";
                color = "#5A56E0";
              };

              work = {
                duration = "25m";
                title = "work session";
                notification = {
                  enabled = true;
                  urgent = false;
                  title = "work finished 🎉";
                  message = "time to take a break";
                };
              };
            }
          '';

          description = ''
            Configuration written to
            {file}`$XDG_CONFIG_HOME/pomo/pomo.yml`
            See
            <https://github.com/Bahaaio/pomo/blob/main/pomo.yaml>
          '';
        };
      };

      config = mkIf cfg.enable {
        home.packages = mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."pomo/pomo.yaml" = mkIf (cfg.settings != { }) {
          source = yamlFormat.generate "hm_pomo.yaml" cfg.settings;
        };
      };
    };

  flake.homeModules.pomo = {
    programs.pomo = {
      enable = true;
      settings = {
        onSessionEnd = "ask";
        asciiArt = {
          enabled = true;
          font = "mono12";
          color = "#5A56E0";
        };
        work = {
          duration = "25m";
          title = "work session";
          notification = {
            enabled = true;
            urgent = false;
            title = "work finished 🎉";
            message = "time to take a break";
          };
        };
        break = {
          duration = "5m";
          title = "break session";
          notification = {
            enabled = true;
            urgent = false;
            title = "break over 😴";
            message = "back to work!";
          };
        };
        longBreak = {
          enabled = true;
          after = 4;
          duration = "20m";
        };
      };
    };
  };
}
