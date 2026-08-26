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
              conform-nvim # For formatting
              dropbar-nvim # Breadcrumbs for neovim
              friendly-snippets # For premade snippets
              guess-indent-nvim # Does what the name says
              lazydev-nvim # Neovim Configuration stuff
              nvim-lightbulb # Just a lightbulb symbol
              luvit-meta # NeoVim configuration

              mini-nvim # MiniMax config

              nvim-dap
              nvim-dap-ui
              nvim-lint
              nvim-lspconfig # Lspconfig contains prebuilt configurations
              rainbow-delimiters-nvim # For delimiters of course
              SchemaStore-nvim # JSON Schemas for neovim
            ];

            optPlugins = [ ];

            treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
              p: with p; [
                bash
                c
                css
                javascript
                jjdescription
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
          # Nix stack
          nixd
          nixfmt

          # Lua stack
          lua-language-server
          (config.programs.stylua.finalPackage)

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
