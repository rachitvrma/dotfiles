# modules/flake/packages/eilmeldung.nix
# Exposes eilmeldung as a flake package. Drop eilmeldung-package.nix
# alongside this file (same directory) before wiring it up.
{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.eilmeldung = pkgs.callPackage ./packages/_eilmeldung-package.nix { };
    };
}
