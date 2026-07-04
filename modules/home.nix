# Use this module for using standalone home-manager

# { self, inputs, ... }:
{
  # flake.homeConfigurations.krish = inputs.home-manager.lib.homeManagerConfiguration {
  #   pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
  #   extraSpecialArgs = { inherit inputs self; };
  #   modules = builtins.attrValues self.homeModules;
  # };
}
