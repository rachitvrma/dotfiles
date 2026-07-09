{
  flake.nixosModules.vcs = { pkgs, ... }: {
    # Git
    programs.git = {
      enable = true;
      package = pkgs.gitFull;
    };
  };

  flake.homeModules.vcs = { pkgs, ... }: {
    home.packages = with pkgs; [ lazyjj ];
    programs = {
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
        settings = {
          git_protocol = "ssh";
        };
      };
      gitui = {
        enable = true;
        keyConfig = ''
          // Note:
          // If the default key layout is lower case,
          // and you want to use `Shift + q` to trigger the exit event,
          // the setting should like this `exit: Some(( code: Char('Q'), modifiers: "SHIFT")),`
          // The Char should be upper case, and the modifier should be set to "SHIFT".
          //
          // Note:
          // find `KeysList` type in src/keys/key_list.rs for all possible keys.
          // every key not overwritten via the config file will use the default specified there
          (
              open_help: Some(( code: F(1), modifiers: "")),

              move_left: Some(( code: Char('h'), modifiers: "")),
              move_right: Some(( code: Char('l'), modifiers: "")),
              move_up: Some(( code: Char('k'), modifiers: "")),
              move_down: Some(( code: Char('j'), modifiers: "")),

              popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
              popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
              page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
              page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
              home: Some(( code: Char('g'), modifiers: "")),
              end: Some(( code: Char('G'), modifiers: "SHIFT")),
              shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
              shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

              edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

              status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

              diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
              diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

              stashing_save: Some(( code: Char('w'), modifiers: "")),
              stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

              stash_open: Some(( code: Char('l'), modifiers: "")),

              abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
          )
        '';
      };
      jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Rachit Kumar Verma";
            email = "155641117+rachitvrma@users.noreply.github.com";
          };
          merge-tools.vimdiff.program = "nvim";
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
    };
  };
}
