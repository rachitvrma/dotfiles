let
  commonSetup = {
    xdg.terminal-exec = {
      enable = true;
      settings = {
        # make sure the terminal is enabled and in $PATH
        default = [ "kitty.desktop" ];
      };
    };
  };
in
{
  flake = {
    nixosModules.xdg-terminal = commonSetup;
    homeModules.xdg-terminal = commonSetup;
  };
}
