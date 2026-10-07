{
  flake.homeModules.nodejs = { ... }: {
    programs = {
      npm.enable = true;
      pnpm.enable = true;
    };
  };
}
