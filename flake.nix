{
  # Inputs are not declared here: they are pinned in .tack/pins.toml and
  # resolved lazily by .tack/default.nix (see README.org).
  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) {
        overrides = {
          inherit self;
        }
        // (args.tackOverrides or { });
      };
      inherit (inputs.nixpkgs) lib;

      # Every .nix file under ./modules is a flake-parts module, except:
      #   - flake.nix / secrets.nix  (not modules)
      #   - files starting with "_"  (plain NixOS/home-manager modules or
      #     data that a flake-parts module imports explicitly)
      importTree =
        path:
        lib.fileset.toList (
          lib.fileset.fileFilter (
            f: f.hasExt "nix" && f.name != "flake.nix" && f.name != "secrets.nix" && !lib.hasPrefix "_" f.name
          ) path
        );
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = importTree ./modules;
    };
}
