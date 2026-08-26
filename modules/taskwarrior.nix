{
  flake.homeModules.taskwarrior = { pkgs, ... }: {
    home.packages = with pkgs; [
      taskwarrior-tui
    ];
    programs.taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3; # Default is taskwarrior2
      config = {
        confirmation = false;
      };
      colorTheme = "dark-violets-256";
    };
  };
}
