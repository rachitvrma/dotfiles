# Host: nixpavilion (HP Pavilion 15, single NVMe, LUKS + btrfs).
#
# This is the only place that assembles a system. Everything in
# self.nixosModules (the files in modules/*.nix) is shared by all hosts;
# the `_`-prefixed files next to this one belong to this host only and are
# skipped by flake.nix's importTree.
{ self, inputs, ... }:
{
  # `disko --flake .#nixpavilion` and `nix run .#...` find the layout here.
  flake.diskoConfigurations.nixpavilion = ./_disko-config.nix;

  flake.nixosConfigurations.nixpavilion = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = builtins.attrValues self.nixosModules ++ [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.nixpavilion
      ./_hardware-configuration.nix
      ./_configuration.nix
      ./_hibernation.nix
    ];
  };
}
