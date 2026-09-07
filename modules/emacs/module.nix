{
  flake.homeModules.emacs = { pkgs, config, ... }: {
    stylix.targets.emacs.opacity.override = rec {
      desktop = 0.9;
      applications = desktop;
      popups = desktop;
      terminal = desktop;
    };
    xdg.configFile = {
      "emacs/init.el".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/etc/nixos/modules/emacs/config/init.el";
      "emacs/early-init.el".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/etc/nixos/modules/emacs/config/early-init.el";
    };

    home = {
      packages = with pkgs; [
        nixd
        nixfmt

        # Aspell is also pulled in by kotatogram
        (aspellWithDicts (
          dicts: with dicts; [
            en
            en-computers
            en-science
          ]
        ))

        # For restarting emacs immediately after rebuild
        (writeShellScriptBin "remacs" ''
          systemctl --user restart emacs.service
          echo "Emacs has been restarted!"
          echo
        '')
      ];
    };
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages =
        epkgs: with epkgs; [
          ace-window
          apheleia
          aria2
          breadcrumb
          consult
          consult-eglot
          consult-eglot-embark
          corfu
          dash
          dashboard
          doom-modeline
          eglot
          embark
          embark-consult
          emms
          indent-bars
          ligature
          magit
          majutsu
          marginalia
          nerd-icons
          nerd-icons-completion
          nerd-icons-corfu
          nerd-icons-dired
          nerd-icons-grep
          nerd-icons-ibuffer
          nerd-icons-xref
          nix-ts-mode
          no-littering
          orderless
          org-auto-tangle
          pulsar # make it shine when you change point
          rainbow-delimiters
          use-package
          vertico
          which-key
          zoxide

          # Tree-sitter grammars
          tree-sitter-indent
          (treesit-grammars.with-grammars (
            grammars: with grammars; [
              tree-sitter-bash
              tree-sitter-nix
            ]
          ))
        ];
    };
    services.emacs = {
      enable = true;
      defaultEditor = true;
      client = {
        enable = true;
      };
      startWithUserSession = "graphical";
    };

    systemd.user.sessionVariables.GDK_BACKEND = "wayland";
    home.sessionVariables.GDK_BACKEND = "wayland";
  };
}
