{
  flake.nixosModules.emacs =
    { pkgs, ... }:
    {
      services.emacs = {
        enable = true;
        package = (pkgs.emacsPackagesFor pkgs.emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]);
        install = true;
        defaultEditor = true;
        startWithGraphical = true;
      };

      environment.systemPackages = with pkgs; [
        luajitPackages.tree-sitter-cli
        (pkgs.aspellWithDicts (
          dicts: with dicts; [
            en
            es
          ]
        ))
      ];
    };
}
