{
  flake.nixosModules.neovim = {
    programs = {
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
        withNodeJs = true;
      };
    };
  };

  flake.homeModules.neovim =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        # Mermaid Diagrams
        mermaid-cli
        mermaid-filter
      ];

      xdg.configFile."stylua/stylua.toml".source = (pkgs.formats.toml { }).generate "hm_stylua.toml" {
        call_parentheses = "Always";
        collapse_simple_statement = "Always";
        column_width = 85;
        indent_type = "Spaces";
        indent_width = 2;
        line_endings = "Unix";
        quote_style = "AutoPreferSingle";
      };

      services = {
        cliphist = {
          enable = true;
          package = pkgs.cliphist.override {
            # We don't need any of these, since I use cliphist only for neovim
            # Fine, just use fzf
            fuzzel = pkgs.fzf;
            fzf = pkgs.fzf;
            wofi = pkgs.fzf;
          };
        };
      };
      programs = {
        neovim = {
          enable = true;
          sideloadInitLua = true;
          defaultEditor = true;
          withNodeJs = true;
          viAlias = true;
          vimAlias = true;
          vimdiffAlias = true;
          waylandSupport = true;
          # For lazydev setup
          initLua = /* lua */ ''
            vim.g.luvit_meta_path = "${pkgs.vimPlugins.luvit-meta}"

            -- This is for C/C++ development
            vim.g.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"
          '';
          withPython3 = true;
          plugins =
            let
              startPlugins = with pkgs.vimPlugins; [
                conform-nvim # For formatting
                friendly-snippets # For premade snippets
                guess-indent-nvim # Does what the name says
                lazydev-nvim # Neovim Configuration stuff
                lz-n # For lazy-loading
                luvit-meta # NeoVim configuration

                mini-nvim # MiniMax config

                nfnl # Use fennel (Lisp) to configure neovim

                nvim-lint
                nvim-lspconfig # Lspconfig contains prebuilt configurations

                # Breadcrumbs plugin for more IDE like feautre
                # Doesn't need to be lazy-loaded, because it does it itself.
                # https://github.com/Bekaboo/dropbar.nvim#:~:text=Lazy%2Dloading%20is%20unneeded%20as%20it%20is%20already%20done%20in%20plugin%2Fdropbar%2Elua%2E
                dropbar-nvim

                # Also comes with its own lazy-loading capabilities
                rainbow-delimiters-nvim # For delimiters of course

              ];

              optPlugins = with pkgs.vimPlugins; [
                image-nvim # View images in neovim
                render-markdown-nvim # For rendering markdown beautifully
                markdown-preview-nvim # Preview markdown in browser

                nvim-lightbulb # Just a lightbulb symbol, shows where a code action is available
                nvim-dap
                nvim-dap-ui
                SchemaStore-nvim # JSON Schemas for neovim
                undotree # For a undotree, of course
              ];

              treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
                p: with p; [
                  bash
                  c
                  cpp
                  css
                  desktop
                  diff
                  editorconfig
                  fennel
                  gitattributes
                  git_config
                  gitignore
                  glsl
                  html
                  javascript
                  jjdescription
                  json
                  kdl
                  latex
                  lua
                  markdown
                  markdown_inline
                  mermaid
                  nix
                  regex
                  ron
                  scss
                  svelte
                  toml
                  tsx
                  typst
                  vue
                  yaml
                  zsh
                ]
              );
            in
            startPlugins
            ++ [ treesitter ]
            ++ map (plugin: {
              inherit plugin;
              optional = true;
            }) optPlugins;

          extraLuaPackages =
            ps: with ps; [
              magick # For image.nvim
            ];
          extraPackages = with pkgs; [
            # Mermaid Diagrams
            mermaid-cli
            mermaid-filter

            # Nix stack
            nixd
            nixfmt

            # LSP server for json & yaml
            vscode-json-languageserver
            yaml-language-server

            # Fennel stack
            fennel-ls # LSP for fennel
            fnlfmt # formatter for fennel

            # Lua stack
            lua-language-server
            stylua

            # Bash/Shell scripts stack
            bash-language-server
            shfmt
            shellcheck

            # C/C++ stack
            clang-tools

            # Shell tools
            ripgrep
            fd

            taplo # for toml

            # for image.nvim
            imagemagick
            ghostscript # For previewing pdf files as well
          ];
        };
      };

      xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/etc/nixos/modules/neovim/nvim";
        recursive = true;
      };
    };
}
