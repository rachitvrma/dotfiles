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

        withPython3 = true;

        plugins =
          let
            startPlugins = with pkgs.vimPlugins; [
              # mini plugins
              conform-nvim # Auto format code
              grug-far-nvim # find and replace
              lz-n # for lazy-loading plugins
              lzn-auto-require # auto-require lazy-loaded specs

              # Mini ecosystem
              mini-ai
              mini-align
              mini-animate
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
              mini-starter
              mini-statusline
              mini-surround
              mini-tabline
              mini-trailspace
              mini-visits

              rainbow-delimiters-nvim
              trouble-nvim
            ];

            treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
              p: with p; [
                c
                cpp
                fish
                json
                kdl
                lua
                markdown
                markdown_inline
                nix
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
      };
    };

    xdg.configFile."nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
