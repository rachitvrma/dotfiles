{
  flake.homeModules.emacs =
    {
      pkgs,
      config,
      ...
    }:
    let
      emacsFiles = [
        "init.el"
        "early-init.el"
      ];
      basePath = "${config.home.homeDirectory}/etc/nixos/modules/emacs/config";
    in
    {
      xdg.configFile = builtins.listToAttrs (
        map (name: {
          name = "emacs/${name}";
          value = {
            source = config.lib.file.mkOutOfStoreSymlink "${basePath}/${name}";
          };
        }) emacsFiles
      );

      home = {
        packages = with pkgs; [
          nixd
          nixfmt

          guile-lsp-server # For guile scheme

          # Bash stack
          bash-language-server
          shfmt
          shellcheck

          vscode-langservers-extracted # HTML, CSS, SCSS, JSON
          typescript-language-server # Javascript
          clang-tools # C/C++ (clangd & clang-format)
          pyright # Python
          yaml-language-server
          taplo # TOML

          # For typst
          tinymist # the lsp server
          typst # The compiler binary
          typstyle # Formatter

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
            consult-todo # Jump between TODO keywords
            corfu
            dash
            dashboard # A nice startup screen
            diff-hl # See git hunks and changes in the line number area
            doom-modeline # A really cool modeline from the doom-emacs stack
            edit-indirect # For editing different regions in different buffers
            editorconfig # Probably a built-in, but still
            eglot # Lsp server configuration, that's actually built-in
            embark
            embark-consult
            ement # Matrix client within emacs
            emms
            ghostel
            hl-todo # Highlight tags like TODO, etc.
            indent-bars
            jsdoc
            ligature
            magit
            majutsu
            marginalia
            multiple-cursors # This is another beast
            neotree # The side tree view of current project dir
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
            page-break-lines
            pomo-cat # A cute kitty pomodoro timer
            posframe # NOTE IDK what it does... Just a dependency
            pulsar # make it shine when you change point
            rainbow-delimiters
            use-package
            vertico
            which-key
            zoxide

            # Tree-sitter grammars
            (treesit-grammars.with-grammars (
              grammars: with grammars; [
                tree-sitter-bash
                tree-sitter-c
                tree-sitter-cpp
                tree-sitter-css
                tree-sitter-diff
                tree-sitter-elisp
                tree-sitter-fennel
                tree-sitter-gitattributes
                tree-sitter-git-config
                tree-sitter-gitignore
                tree-sitter-glsl
                tree-sitter-html
                tree-sitter-javascript
                tree-sitter-jjdescription
                tree-sitter-jsdoc
                tree-sitter-json
                tree-sitter-kdl
                tree-sitter-latex
                tree-sitter-lua
                tree-sitter-markdown
                tree-sitter-markdown-inline
                tree-sitter-mermaid
                tree-sitter-nix
                tree-sitter-python
                tree-sitter-regex
                tree-sitter-ron
                tree-sitter-scheme
                tree-sitter-scss
                tree-sitter-svelte
                tree-sitter-toml
                tree-sitter-tsx
                tree-sitter-typst
                tree-sitter-vue
                tree-sitter-xml
                tree-sitter-yaml
              ]
            ))
          ];
      };
      services.emacs = {
        enable = true;
        defaultEditor = true;
        client = {
          enable = true;
          arguments = [
            "-c"
            "-a"
            "emacs"
          ];
        };
        startWithUserSession = "graphical";
      };

      systemd.user.sessionVariables.GDK_BACKEND = "wayland";
      home.sessionVariables.GDK_BACKEND = "wayland";
    };
}
