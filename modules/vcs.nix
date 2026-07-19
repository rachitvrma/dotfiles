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
      gh-dash.enable = true;
      gitui = {
        enable = true;
        keyConfig = /* ron */ ''
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

        theme = /* ron */ ''
          (
              selected_tab: Some("Reset"),
              command_fg: Some("#ddc7a1"),
              selection_bg: Some("#bdae93"),
              selection_fg: Some("#ddc7a1"),
              cmdbar_bg: Some("#1d2021"),
              cmdbar_extra_lines_bg: Some("#1d2021"),
              disabled_fg: Some("#bdae93"),
              diff_line_add: Some("#a9b665"),
              diff_line_delete: Some("#ea6962"),
              diff_file_added: Some("#d8a657"),
              diff_file_removed: Some("#ea6962"),
              diff_file_moved: Some("#d3869b"),
              diff_file_modified: Some("#e78a4e"),
              commit_hash: Some("#fbf1c7"),
              commit_time: Some("#ddc7a1"),
              commit_author: Some("#7daea3"),
              danger_fg: Some("#ea6962"),
              push_gauge_bg: Some("#7daea3"),
              push_gauge_fg: Some("#141617"),
              tag_fg: Some("#ebdbb2"),
              branch_fg: Some("#89b482"),
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
          ui.default-command = "log";
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
