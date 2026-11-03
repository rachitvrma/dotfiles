{
  flake.nixosModules.devtools =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        just
        stow
        unzip
        gcc
        cargo
        pnpm
        ruff
        dprint
        nixd
        nixfmt
        jujutsu
        gh
        jq
      ];
      programs.npm.enable = true;
      programs.devenv.enable = true;
    };
}
