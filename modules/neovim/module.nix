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

  flake.homeModules.neovim = { pkgs, config, ... }: {
    # NOTE: there's a pr to use tinted-nvim rather than mini.base16
    # when it's merged, just use it.
    # stylix.targets.neovim.enable = false;

    # Snacks.nvim needs this for the Snacks.picker.cliphist()
    services.cliphist.enable = true;

    programs = {
      # NOTE: this is custom module.
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
        '';
        withPython3 = true;
        plugins =
          let
            startPlugins = with pkgs.vimPlugins; [
              aerial-nvim # For function and navigation and stuff
              bufferline-nvim # Tabline plugin
              conform-nvim # For formatting
              dropbar-nvim # Breadcrumbs for neovim
              friendly-snippets # For premade snippets
              gitsigns-nvim # See git info in the colorcolumn
              guess-indent-nvim # Does what the name says
              lazydev-nvim # Neovim Configuration stuff
              nvim-lightbulb # Just a lightbulb symbol
              luasnip # For snippet generation
              luvit-meta # NeoVim configuration
              lz-n # for lazy-loading plugins
              lzn-auto-require # auto-require lazy-loaded specs

              mini-icons # For extra set of icons
              mini-statusline # For a good statusline, I guess

              neovim-project # Better project management and navigation
              nvim-dap
              nvim-dap-ui
              nvim-highlight-colors
              nvim-lint
              nvim-lspconfig # Lspconfig contains prebuilt configurations
              rainbow-delimiters-nvim # For delimiters of course
              SchemaStore-nvim # JSON Schemas for neovim

              todo-comments-nvim

              snacks-nvim # QoL plugins
            ];

            optPlugins = with pkgs.vimPlugins; [
              trouble-nvim # For diagnostics management
              which-key-nvim # It can be lazy-loaded using lz.n
            ];

            treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
              p: with p; [
                bash
                c
                css
                javascript
                latex
                scss
                svelte
                tsx
                typst
                vue
                cpp
                html
                json
                kdl
                lua
                regex
                markdown
                markdown_inline
                nix
                ron
                toml
                yaml
              ]
            );
          in
          startPlugins
          ++ [ treesitter ]
          ++ map (plugin: {
            inherit plugin;
            optional = true;
          }) optPlugins;

        extraLuaPackages = ps: with ps; [ magick ];
        extraPackages = with pkgs; [
          sqlite # For frecency storage
          dwt1-shell-color-scripts # For snacks dashboard
          ghostscript # For rendering pdfs
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
        ];
      };
    };

    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/etc/nixos/modules/neovim/nvim";
      recursive = true;
    };
  };
}
