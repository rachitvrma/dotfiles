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
        (aspellWithDicts (
          dicts: with dicts; [
            en
            es
          ]
        ))
        # LaTeX: AUCTeX runs latexmk, eglot runs texlab
        texliveMedium
        texlab

        # Language servers named in init-prog.el
        tombi
        just-lsp
        systemd-lsp
        fish-lsp
        vscode-langservers-extracted

        # Only needed once you wire PlantUML into Emacs (step 4)
        plantuml
      ];
    };
}
