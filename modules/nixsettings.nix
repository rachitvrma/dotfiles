{ inputs, me, ... }:
{
  flake.nixosModules.nixsettings =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];

      nixpkgs.overlays = [
        (final: prev: {
          inherit (prev.lixPackageSets.stable)
            nixpkgs-review
            nix-eval-jobs
            nix-fast-build
            colmena
            ;
        })
      ];

      nix = {
        package = pkgs.lixPackageSets.stable.lix;
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          show-trace = true;
          # NOTE: lets any flake you build set substituters/hooks. Convenient,
          # but think about it before building flakes you do not trust.
          accept-flake-config = true;
          # root-equivalent. The primary user is in wheel already.
          trusted-users = [ "@wheel" ];
        };

        # Flake-only system: no channels, <nixpkgs> comes from the pinned input.
        channel.enable = false;
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

        registry = {
          nixpkgs.flake = inputs.nixpkgs;
          nixpavilion.flake = inputs.self;
        };
      };

      programs = {
        tack = {
          enable = true;
          nixConfTokens = true;
        };
        # Prebuilt index for nix-locate and `comma`.
        nix-index-database.comma.enable = true;
        nix-index.enable = true;
        nh = {
          enable = true;
          flake = "/home/${me.username}/etc/nixos";
          clean = {
            enable = true;
            extraArgs = "--keep 5 --keep-since 3d";
          };
        };
      };
    };
}
