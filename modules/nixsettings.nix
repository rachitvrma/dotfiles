{ inputs, ... }: {
  flake.nixosModules.nixsettings = {
    imports = [ inputs.nix-index-database.nixosModules.nix-index ];

    nix = {
      # When using home-manager as nixos module, comment this out
      # package = pkgs.lix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        cores = 8;
        max-jobs = 1;
        show-trace = true;
      };

      nixPath = [
        "nixpkgs=${builtins.path { path = inputs.nixpkgs; }}"
      ];
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
        # wrappers.flake = inputs.wrappers;
        home-manager.flake = inputs.home-manager;
        nixpavilion.flake = inputs.self;
      };
    };

    programs = {
      nix-index-database.comma.enable = true;
      nix-index.enable = true;
      nh = {
        enable = true;
        flake = "/home/krish/etc/nixos";
        clean = {
          enable = true;
          extraArgs = "--keep 5 --keep-since 3d";
        };
      };
    };
  };

  flake.homeModules.nixsettings = { pkgs, config, ... }: {
    imports = [
      inputs.nix-index-database.homeModules.default
    ];

    home.packages = with pkgs; [
      nix-prefetch
      nix-prefetch-github
      nix-auth
    ];

    programs = {
      # Integrates with home-manager managed shell
      nix-index.enable = true;
      nix-index-database.comma.enable = true;

      nh = {
        enable = true;
        clean = {
          enable = true;
          dates = "daily";
          extraArgs = "--keep 5 --keep-since 3d";
        };
      };
    };

    nix = {
      # When using home-manager as nixos module, comment this out
      # package = pkgs.lix;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        cores = 8;
        max-jobs = 1;
        show-trace = true;
      };
      extraOptions = ''
        !include ${config.xdg.configHome}/nix/access-tokens.conf
      '';
      nixPath = [
        "nixpkgs=${builtins.path { path = inputs.nixpkgs; }}"
      ];
      registry = {
        nixpkgs.flake = inputs.nixpkgs;
        # wrappers.flake = inputs.wrappers;
        home-manager.flake = inputs.home-manager;
        nixpavilion.flake = inputs.self;
      };
    };
  };
}
