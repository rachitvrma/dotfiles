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

      environment.systemPackages = [
        (pkgs.aspellWithDicts (
          dicts: with dicts; [
            en
            es
          ]
        ))
      ];
    };
}
