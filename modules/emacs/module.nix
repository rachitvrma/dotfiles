{
  flake.nixosModules.editors = {
    programs = {
      nano.enable = false;
      vim.enable = true;
    };
  };
  flake.homeModules.emacs = { pkgs, ... }: {
    # To check emacsPackages in the nixpkgs repo use
    # nix-env -f '<nixpkgs>' -qaP -A emacsPackages

    services.emacs = {
      enable = true;
      client = {
        enable = true;
        arguments = [ "-c" ];
      };

      defaultEditor = true;

      startWithUserSession = "graphical";
    };

    xdg.configFile = {
      "emacs/init.el".source = ./init.el;
      "emacs/early-init.el".source = ./early-init.el;
    };

    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;

      extraPackages =
        epkgs: with epkgs; [
          ace-window
          apheleia
          aria2
          avy
          base16-theme
          colorful-mode
          consult
          consult-gh
          consult-todo
          dashboard
          diff-hl
          diredfl
          dirvish
          doom-modeline
          eglot
          embark
          embark-consult
          emms
          envrc
          exec-path-from-shell
          ghostel
          git-modes
          hl-todo
          indent-bars
          kdl-mode
          ligature
          magit
          magit-todos
          marginalia
          nerd-icons
          nerd-icons-completion
          nerd-icons-ibuffer
          nix-ts-mode
          no-littering
          olivetti
          orderless
          org
          org-auto-tangle
          org-modern
          page-break-lines
          project
          pulsar
          rainbow-delimiters
          use-package
          vertico
          which-key

          (treesit-grammars.with-grammars (
            grammars: with grammars; [
              tree-sitter-c
              tree-sitter-css
              tree-sitter-html
              tree-sitter-javascript
              tree-sitter-json
              tree-sitter-markdown
              tree-sitter-bash
              tree-sitter-nix
              tree-sitter-python
              tree-sitter-toml
              tree-sitter-yaml
            ]
          ))
        ];
    };

    home.packages = with pkgs; [
      # The bash scripting stack
      bash-language-server
      shfmt
      shellcheck

      # Python stack
      basedpyright

      nixd
      nixfmt

      gh

      figlet

      (aspellWithDicts (
        dicts: with dicts; [
          en
          en-computers
          en-science
          es
        ]
      ))

      (pkgs.writeShellScriptBin "epkgs" ''
        set -euo pipefail
        nix-env -f '<nixpkgs>' -qaP -A emacsPackages
      '')

      (pkgs.writeShellScriptBin "remacs" ''
        set -euo pipefail
        systemctl --user restart emacs
      '')
    ];
  };
}
