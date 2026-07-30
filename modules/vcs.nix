{
  flake.nixosModules.vcs = { pkgs, ... }: {
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
            fg = "#5a524c";
          };
          branch = {
            fg = "#e78a4e";
          };
          change = {
            fg = "#ea6962";
          };
          commit = {
            fg = "#a9b665";
          };
          completion = {
            fg = "#ddc7a1";
          };
          "completion selected" = {
            bold = true;
          };
          confirmation = {
            bg = "#141617";
          };
          "confirmation border" = {
            bold = true;
            fg = "#ea6962";
          };
          "confirmation dimmed" = {
            fg = "#5a524c";
          };
          "confirmation selected" = {
            bg = "#504945";
            fg = "#ddc7a1";
          };
          "confirmation text" = {
            bold = true;
            fg = "#7daea3";
          };
          details = {
            fg = "#ddc7a1";
          };
          "details selected" = {
            bold = true;
          };
          dimmed = {
            bg = "#141617";
            fg = "#5a524c";
          };
          error = {
            bold = true;
            fg = "#ea6962";
          };
          evolog = {
            fg = "#ddc7a1";
          };
          "evolog selected" = {
            bg = "#504945";
            bold = true;
            fg = "#ddc7a1";
          };
          file = {
            fg = "#d8a657";
          };
          help = {
            bg = "#141617";
          };
          "help border" = {
            fg = "#2a2827";
          };
          "help title" = {
            bold = true;
            fg = "#a9b665";
            underline = true;
          };
          matched = {
            fg = "#d8a657";
          };
          menu = {
            bg = "#141617";
          };
          "menu border" = {
            fg = "#2a2827";
          };
          "menu dimmed" = {
            fg = "#5a524c";
          };
          "menu matched" = {
            bold = true;
            fg = "#d8a657";
          };
          "menu selected" = {
            bg = "#504945";
            fg = "#ddc7a1";
          };
          "menu shortcut" = {
            fg = "#d3869b";
          };
          "menu title" = {
            bg = "#d3869b";
            bold = true;
            fg = "#141617";
          };
          "oplog selected" = {
            bold = true;
          };
          preview = {
            fg = "#ddc7a1";
          };
          "preview border" = {
            fg = "#2a2827";
          };
          rebase = {
            bold = true;
          };
          revisions = {
            fg = "#ddc7a1";
          };
          "revisions details selected" = {
            bg = "#504945";
          };
          "revisions dimmed" = {
            fg = "#5a524c";
          };
          "revisions rebase source_marker" = {
            bold = true;
          };
          "revisions rebase target_marker" = {
            bold = true;
          };
          "revisions selected" = {
            bg = "#2a2827";
          };
          "revset completion dimmed" = {
            fg = "#5a524c";
          };
          "revset completion matched" = {
            bold = true;
            fg = "#d8a657";
          };
          "revset completion selected" = {
            bg = "#504945";
            fg = "#ddc7a1";
          };
          "revset completion text" = {
            fg = "#ddc7a1";
          };
          "revset text" = {
            bold = true;
            fg = "#ddc7a1";
          };
          "revset title" = {
            bold = true;
            fg = "#7daea3";
          };
          selected = {
            bg = "#2a2827";
            bold = true;
            fg = "#ddc7a1";
          };
          shortcut = {
            fg = "#d3869b";
          };
          source_marker = {
            bg = "#89b482";
            bold = true;
            fg = "#141617";
          };
          status = {
            bg = "#2a2827";
          };
          "status dimmed" = {
            fg = "#5a524c";
          };
          "status shortcut" = {
            fg = "#d3869b";
          };
          "status title" = {
            bg = "#7daea3";
            bold = true;
            fg = "#141617";
          };
          success = {
            bold = true;
            fg = "#a9b665";
          };
          target_marker = {
            bg = "#a9b665";
            bold = true;
            fg = "#141617";
          };
          text = {
            bg = "#141617";
            fg = "#ddc7a1";
          };
          title = {
            bold = true;
            fg = "#7daea3";
          };
          undo = {
            bg = "#141617";
          };
          "undo confirmation dimmed" = {
            fg = "#5a524c";
          };
          "undo confirmation selected" = {
            bg = "#504945";
            fg = "#ddc7a1";
          };
          workspace = {
            fg = "#7daea3";
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
            editor = "nvim";
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
        enableZshIntegration = true; # Use 'lg' to start lazygit
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
}
