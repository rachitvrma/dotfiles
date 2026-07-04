{
  flake.homeModules.python = {
    programs = {
      ruff.enable = true;
      matplotlib.enable = true;
      pylint.enable = true;
      uv.enable = true;
      pyenv.enable = true;
    };
  };
}
