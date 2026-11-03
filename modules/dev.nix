# `nix fmt` and `nix develop` for working on this repository.
{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt;

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          just
          stow
          nixd
          nixfmt
          inputs.agenix.packages.${stdenv.hostPlatform.system}.default
        ];
      };
    };
}
