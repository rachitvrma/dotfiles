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
    let
      colors = config.lib.stylix.colors.withHashtag;
    in
    {
      # NOTE: There's a PR to use tinted-nvim rather than mini.base16
      # When it's merged, just use it.
      stylix.targets.neovim.enable = false;

      programs = {
        # NOTE: This is custom module.
        stylua = {
          enable = true;
          settings = {
            call_parentheses = "Always";
            collapse_simple_statement = "Always";
            column_width = 85;
            indent_type = "Spaces";
            indent_width = 2;
            line_endings = "Unix";
            quote_style = "AutoPreferSingle";
          };
        };

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

            vim.g.stylix_colors = {
              base00 = "${colors.base00}",
              base01 = "${colors.base01}",
              base02 = "${colors.base02}",
              base03 = "${colors.base03}",
              base04 = "${colors.base04}",
              base05 = "${colors.base05}",
              base06 = "${colors.base06}",
              base07 = "${colors.base07}",
              base08 = "${colors.base08}",
              base09 = "${colors.base09}",
              base0A = "${colors.base0A}",
              base0B = "${colors.base0B}",
              base0C = "${colors.base0C}",
              base0D = "${colors.base0D}",
              base0E = "${colors.base0E}",
              base0F = "${colors.base0F}",
            }
          '';
          withPython3 = true;
          plugins =
            let
              startPlugins = with pkgs.vimPlugins; [
                aerial-nvim # For function and navigation and stuff
                blink-cmp # Completion engine
                bufferline-nvim # For a list of tabs and buffers
                conform-nvim # For formatting
                fidget-nvim # For lsp notifications
                gitsigns-nvim # See git info in the colorcolumn
                guess-indent-nvim # Does what the name says
                indent-blankline-nvim # Does what it says
                lazydev-nvim # Neovim Configuration stuff
                lualine-nvim # For a good status bar
                luasnip # For snippet generation
                luvit-meta # NeoVim configuration
                lz-n # for lazy-loading plugins
                lzn-auto-require # auto-require lazy-loaded specs

                # NOTE: Neo-tree lazily loads itself
                neo-tree-nvim # For a good filemanager

                nvim-autopairs # Autopairs
                nvim-dap
                nvim-dap-ui
                nvim-highlight-colors
                nvim-lint
                nvim-lspconfig # Lspconfig contains prebuilt configurations
                nvim-notify # A notification plugin
                nvim-web-devicons # For icons
                rainbow-delimiters-nvim # For delimiters of course
                SchemaStore-nvim # JSON Schemas for neovim

                # The beast is here
                telescope-nvim
                telescope-ui-select-nvim

                tinted-nvim
                todo-comments-nvim
                which-key-nvim
              ];

              treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
                p: with p; [
                  bash
                  c
                  cpp
                  html
                  json
                  kdl
                  lua
                  markdown
                  markdown_inline
                  nix
                  ron
                  toml
                  yaml
                ]
              );

              optPlugins = with pkgs.vimPlugins; [
                trouble-nvim # For diagnostics management
              ];
            in
            startPlugins
            ++ [ treesitter ]
            ++ map (plugin: {
              inherit plugin;
              optional = true;
            }) optPlugins;

          extraLuaPackages = ps: with ps; [ magick ];
          extraPackages = with pkgs; [
            # Nix stack
            nixd
            nixfmt

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

            markdownlint-cli2
          ];
        };
      };

      xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/etc/nixos/modules/neovim/nvim";
        recursive = true;
      };
    };
}
