# Settings every NixOS host of this flake shares.
# The hosts themselves live in ./hosts/<name>/default.nix.
{ inputs, ... }:
{
  flake.nixosModules.nixos = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        # NUR
        inputs.nur.overlays.default
        # self.overlays.default # my own overlays
      ];
    };
  };
}
