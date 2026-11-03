{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    # Declares flake.homeModules / flake.homeConfigurations.
    # inputs.home-manager.flakeModules.home-manager
  ];

  systems = [ "x86_64-linux" ];
}
