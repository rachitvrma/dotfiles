let
  commonSettings = {
    global = {
      warn_timeout = "30s"; # default is 5s — way too aggressive for a Nix/Guix eval that's building
      load_dotenv = true; # picks up .env alongside .envrc, useful if a project has one
      hide_env_diff = false; # keep the diff visible while you're still debugging which tool set what
    };

    whitelist = {
      prefix = [ "~/Projects" ]; # auto-allow .envrc under your projects dir without repeated `direnv allow`
    };
  };
in
{
  flake.nixosModules.direnv = {
    programs.direnv = {
      enable = true;
      settings = commonSettings;
    };
  };
  flake.homeModules.direnv = {
    programs.direnv = {
      enable = true;
      enableGitIntegration = true;
      config = commonSettings;
    };
  };
}
