{
  flake.nixosModules.neovim = {
    programs = {
      neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
      };
    };
  };

  flake.homeModules.neovim = { pkgs, ... }: {
    programs = {
      neovim = {
        enable = true;
        sideloadInitLua = true;
        defaultEditor = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        waylandSupport = true;

        # For lazydev setup
        initLua = ''
          vim.g.luvit_meta_path = "${pkgs.vimPlugins.luvit-meta}"
        '';

        withPython3 = true;

        plugins =
          let
            startPlugins = with pkgs.vimPlugins; [
              conform-nvim # Auto format code
              dropbar-nvim # IDE-Like Breadcrumbs
              grug-far-nvim # find and replace
              image-nvim # image in neovim
              nvim-lspconfig # Lspconfig contains prebuilt configurations

              # Neovim Configuration
              lazydev-nvim
              luvit-meta

              lz-n # for lazy-loading plugins
              lzn-auto-require # auto-require lazy-loaded specs

              # Mini ecosystem
              mini-ai
              mini-align
              mini-animate
              mini-base16
              mini-basics
              mini-bracketed
              mini-bufremove
              mini-clue
              mini-cmdline
              mini-comment
              mini-completion
              mini-cursorword
              mini-diff
              mini-doc
              mini-extra
              mini-files
              mini-fuzzy
              mini-git
              mini-hipatterns
              mini-icons
              mini-indentscope
              mini-jump
              mini-jump2d
              mini-keymap
              mini-map
              mini-misc
              mini-move
              mini-notify
              mini-pairs
              mini-pick
              mini-sessions
              mini-snippets
              mini-splitjoin
              mini-starter # replaced by alpha.nvim
              mini-statusline
              mini-surround
              mini-tabline
              mini-trailspace
              mini-visits

              project-nvim

              rainbow-delimiters-nvim
              trouble-nvim
            ];

            treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
              p: with p; [
                bash
                c
                cpp
                fish
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
              # Markdown stack
              mkdnflow-nvim
              render-markdown-nvim
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

          # Shell tools
          ripgrep
          fd

          imagemagick # image.nvim stack
        ];
      };
    };

    xdg.configFile."nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
