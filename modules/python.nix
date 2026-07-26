{
  flake.homeModules.python = {
    programs = {
      ruff.enable = true;
      matplotlib = {
        enable = true;
        config = {
          axes = {
            edgecolor = "FF9900";
            facecolor = "black";
            grid = true;
          };
          backend = "Qt5Agg";
          grid = {
            color = "FF9900";
          };
        };
      };
      pylint.enable = true;
      uv.enable = true;
      pyenv.enable = true;
    };
  };
}
