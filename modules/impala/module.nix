{
  flake.homeModules.impala = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ impala ];
    xdg.configFile."impala/config.toml".source = (pkgs.formats.toml { }).generate "hm_impala" (
      lib.importTOML ./impala.toml
    );
  };
}
