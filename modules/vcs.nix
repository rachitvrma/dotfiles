# TODO: need to fix lazyworktree's shell integration.
{ self, ... }: {
  # This provides the temporary fix for now.
  flake.overlays.default = final: prev: {
    lazyworktree = prev.lazyworktree.overrideAttrs (old: {
      postInstall =
        builtins.replaceStrings
          [ "completion bash --code" "completion zsh --code" "completion fish --code" ]
          [ "completion bash" "completion zsh" "completion fish" ]
          old.postInstall;
    });
  };

  flake.nixosModules.vcs = { pkgs, ... }: {
    # import the temporary lazyworktree fix
    nixpkgs.overlays = [ self.overlays.default ];
    # Git
    programs = {
      git = {
        enable = true;
        package = pkgs.gitFull;
      };
      lazygit = {
        enable = true;
        settings = {
          gui = {
            theme = {
              activeBorderColor = [
                "#d3869b"
                "bold"
              ];
              inactiveBorderColor = [ "#5a524c" ];
              searchingActiveBorderColor = [
                "#d8a657"
                "bold"
              ];
              optionsTextColor = [ "#7daea3" ];
              selectedLineBgColor = [ "#282828" ];
              inactiveViewSelectedLineBgColor = [ "bold" ];
              cherryPickedCommitFgColor = [ "#7daea3" ];
              cherryPickedCommitBgColor = [ "#282828" ];
              markedBaseCommitFgColor = [ "#d3869b" ];
              markedBaseCommitBgColor = [ "#282828" ];
              unstagedChangesColor = [ "#ea6962" ];
              defaultFgColor = [ "#ebdbb2" ];
            };
            authorColors = {
              "*" = "#89b482";
            };
          };
        };
      };
    };
  };

  flake.homeModules.vcs = { pkgs, ... }: {
    xdg.configFile."jjui/themes/base24-gruvbox-dark.toml".source =
      (pkgs.formats.toml { }).generate "jjui_theme_base24-gruvbox-dark"
        {
          bookmark = {
            fg = "#d3869b";
          };
          border = {
            fg = "#665c54";
          };
          branch = {
            fg = "#8ec07c";
          };
          change = {
            fg = "#fb4934";
          };
          commit = {
            fg = "#b8bb26";
          };
          completion = {
            fg = "#ebdbb2";
          };
          "completion selected" = {
            bold = true;
          };
          confirmation = {
            bg = "#282828";
          };
          "confirmation border" = {
            bold = true;
            fg = "#fb4934";
          };
          "confirmation dimmed" = {
            fg = "#665c54";
          };
          "confirmation selected" = {
            bg = "#504945";
            fg = "#ebdbb2";
          };
          "confirmation text" = {
            bold = true;
            fg = "#458588";
          };
          details = {
            fg = "#ebdbb2";
          };
          "details selected" = {
            bold = true;
          };
          dimmed = {
            bg = "#282828";
            fg = "#665c54";
          };
          error = {
            bold = true;
            fg = "#fb4934";
          };
          evolog = {
            fg = "#ebdbb2";
          };
          "evolog selected" = {
            bg = "#504945";
            bold = true;
            fg = "#ebdbb2";
          };
          file = {
            fg = "#fabd2f";
          };
          help = {
            bg = "#282828";
          };
          "help border" = {
            fg = "#3c3836";
          };
          "help title" = {
            bold = true;
            fg = "#b8bb26";
            underline = true;
          };
          matched = {
            fg = "#fabd2f";
          };
          menu = {
            bg = "#282828";
          };
          "menu border" = {
            fg = "#3c3836";
          };
          "menu dimmed" = {
            fg = "#665c54";
          };
          "menu matched" = {
            bold = true;
            fg = "#fabd2f";
          };
          "menu selected" = {
            bg = "#504945";
            fg = "#ebdbb2";
          };
          "menu shortcut" = {
            fg = "#d3869b";
          };
          "menu title" = {
            bg = "#d3869b";
            bold = true;
            fg = "#282828";
          };
          "oplog selected" = {
            bold = true;
          };
          preview = {
            fg = "#ebdbb2";
          };
          "preview border" = {
            fg = "#3c3836";
          };
          rebase = {
            bold = true;
          };
          revisions = {
            fg = "#ebdbb2";
          };
          "revisions details selected" = {
            bg = "#504945";
          };
          "revisions dimmed" = {
            fg = "#665c54";
          };
          "revisions rebase source_marker" = {
            bold = true;
          };
          "revisions rebase target_marker" = {
            bold = true;
          };
          "revisions selected" = {
            bg = "#3c3836";
          };
          "revset completion dimmed" = {
            fg = "#665c54";
          };
          "revset completion matched" = {
            bold = true;
            fg = "#fabd2f";
          };
          "revset completion selected" = {
            bg = "#504945";
            fg = "#ebdbb2";
          };
          "revset completion text" = {
            fg = "#ebdbb2";
          };
          "revset text" = {
            bold = true;
            fg = "#ebdbb2";
          };
          "revset title" = {
            bold = true;
            fg = "#458588";
          };
          selected = {
            bg = "#3c3836";
            bold = true;
            fg = "#ebdbb2";
          };
          shortcut = {
            fg = "#b16286";
          };
          source_marker = {
            bg = "#8ec07c";
            bold = true;
            fg = "#282828";
          };
          status = {
            bg = "#3c3836";
          };
          "status dimmed" = {
            fg = "#665c54";
          };
          "status shortcut" = {
            fg = "#d3869b";
          };
          "status title" = {
            bg = "#83a598";
            bold = true;
            fg = "#282828";
          };
          success = {
            bold = true;
            fg = "#b8bb26";
          };
          target_marker = {
            bg = "#b8bb26";
            bold = true;
            fg = "#282828";
          };
          text = {
            bg = "#282828";
            fg = "#ebdbb2";
          };
          title = {
            bold = true;
            fg = "#458588";
          };
          undo = {
            bg = "#282828";
          };
          "undo confirmation dimmed" = {
            fg = "#665c54";
          };
          "undo confirmation selected" = {
            bg = "#504945";
            fg = "#ebdbb2";
          };
          workspace = {
            fg = "#83a598";
          };
        };

    programs = {
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings = {
          git_protocol = "ssh";
        };
      };
      gh-dash.enable = true;

      # Jujutsu Stack
      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Rachit Kumar Verma";
            email = "155641117+rachitvrma@users.noreply.github.com";
          };
          ui.default-command = "log";
          merge-tools.vimdiff.program = "nvim";
        };
      };

      # TODO: Configure this beast
      # TODO: Make a themes module for it.
      jjui = {
        enable = true;
        settings = {
          ui.theme = "base24-gruvbox-dark";
        };
      };

      git = {
        enable = true;
        package = pkgs.gitFull;
        settings = {
          init.defaultBranch = "main";
          push = {
            autoSetupRemote = true;
            default = "simple";
          };
          rebase.autoStash = true;
          core = {
            untrackedCache = true;
            fsmonitor = true;
          };
          diff.algorithm = "histogram";
          user = {
            name = "Rachit Kumar Verma";
            email = "155641117+rachitvrma@users.noreply.github.com";
          };
          remote.pushDefault = "origin";
          alias = {
            co = "checkout";
            s = "status";
            ss = "status --short --branch";
            ci = "commit";
            br = "branch";
            # Better log
            lg = "log --oneline --graph --decorate --all";

            # Sync local main with upstream and update your fork (origin)
            # Assumes that upstream is set
            sync = "!f() { git checkout main && git pull upstream main && git push origin main; }; f";

            # Update current branch by rebasing onto the remote to avoid merge bubbles
            up = "pull --rebase --autostash";
            # Quick stash including untracked files
            stsh = "stash push -u -m";

            dev = "!direnv reload";
          };
          merge.conflictstyle = "zdiff3";
          rerere.enabled = true;
          commit.verbose = true;
          fetch.prune = true;
          color.ui = "auto";
        };
        ignores = [
          # Ignore gitingest's output
          "digest.txt"

          "Thumbs.db"
          "desktop.ini"

          # Generic temp/cache
          "*.tmp"
          "*.temp"
          "*.cache"
          ".cache/"

          # Logs
          "*.log"

          # Patch leftovers
          "*.orig"
          "*.rej"

          # Backups
          "*.bak"

          # Editor Temp
          "*~"
          "*.swp"
          "*.swo"
          "*.swx"

          ".direnv"

          # Python
          "__pycache__/"
          "*.py[cod]"
          ".venv/"
          "venv/"

          # Secrets
          ".env"
          ".env.*"

          # Editors
          ".vscode/"
          ".idea/"

          # OS
          ".DS_Store"

          # Build
          "dist/"
          "build/"
          "*.egg-info/"
        ];
      };
      lazygit = {
        enable = true;
        enableFishIntegration = true; # Use 'lg' to start lazygit
        settings = {
          gui = {
            theme = {
              activeBorderColor = [
                "#d3869b"
                "bold"
              ];
              inactiveBorderColor = [ "#5a524c" ];
              searchingActiveBorderColor = [
                "#d8a657"
                "bold"
              ];
              optionsTextColor = [ "#7daea3" ];
              selectedLineBgColor = [ "#282828" ];
              inactiveViewSelectedLineBgColor = [ "bold" ];
              cherryPickedCommitFgColor = [ "#7daea3" ];
              cherryPickedCommitBgColor = [ "#282828" ];
              markedBaseCommitFgColor = [ "#d3869b" ];
              markedBaseCommitBgColor = [ "#282828" ];
              unstagedChangesColor = [ "#ea6962" ];
              defaultFgColor = [ "#ebdbb2" ];
            };
            authorColors = {
              "*" = "#89b482";
            };
          };
        };
      };
      lazyworktree = {
        enable = true;
        # BUG: This doesn't work in home-manager's module
        # I am using a fix. See the lazyworktree-fix module below.
        enableFishIntegration = true;
        settings = {
          theme = "gruvbox-material-dark-hard";
          custom_themes = {
            gruvbox-material-dark-hard = {
              accent = "#d3869b";
              accent_fg = "#141617";
              accent_dim = "#282828";
              border = "#7daea3";
              border_dim = "#5a524c";
              muted_fg = "#bdae93";
              text_fg = "#ebdbb2";
              success_fg = "#a9b665";
              warn_fg = "#d8a657";
              error_fg = "#ea6962";
              cyan = "#89b482";
            };
          };
        };
      };
    };
  };
}
