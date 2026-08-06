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
      };
    };
  };

  flake.homeModules.vcs = { pkgs, ... }: {
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
          ui = {
            default-command = "log";
            diff-editor = ":builtin";
            merge-tools = ":builtin";
            merge-editor = ":builtin";
          };
          merge-tools.vimdiff.program = "nvim";
        };
      };

      # TODO: Configure this beast
      # TODO: Make a themes module for it.
      jjui = {
        enable = true;
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
      };
    };
  };
}
