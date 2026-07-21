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
      jjui.enable = true;

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

  flake.homeModule.lazyworktree-fix =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      inherit (lib)
        mkIf
        mkEnableOption
        mkPackageOption
        mkOption
        ;
      cfg = config.programs.lazyworktree;
      yamlFormat = pkgs.formats.yaml { };
    in
    {
      options.programs.lazyworktree = {
        enable = mkEnableOption "lazyworktree";

        package = mkPackageOption pkgs "lazyworktree" { nullable = true; };

        settings = mkOption {
          inherit (yamlFormat) type;
          default = { };
          example = {
            worktree_dir = "~/.local/share/worktrees";
            sort_mode = "switched";
            layout = "default";
            auto_refresh = true;
            ci_auto_refresh = false;
            refresh_interval = 10;
            disable_pr = false;
            icon_set = "nerd-font-v3";
            search_auto_select = false;
            fuzzy_finder_input = false;
            palette_mru = true;
            palette_mru_limit = 5;
          };
          description = ''
            Configuration written to
            {file}`$XDG_CONFIG_HOME/lazyworktree/config.yaml`.
            See
            <https://github.com/chmouel/lazyworktree?tab=readme-ov-file#global-configuration-yaml>
            for supported values.
          '';
        };

        enableBashIntegration = lib.hm.shell.mkBashIntegrationOption { inherit config; };

        enableFishIntegration = lib.hm.shell.mkFishIntegrationOption { inherit config; };

        enableZshIntegration = lib.hm.shell.mkZshIntegrationOption { inherit config; };

        shellWrapperName = mkOption {
          type = lib.types.str;
          default = "lwt";
          example = "wt";
          description = ''
            Name of the shell wrapper that launches lazyworktree and changes to the
            selected worktree directory on exit.
            This option only has an effect when at least one shell integration
            option is enabled.
          '';
        };
      };

      config = mkIf cfg.enable {
        home.packages = mkIf (cfg.package != null) [ cfg.package ];

        xdg.configFile."lazyworktree/config.yaml" = mkIf (cfg.settings != { }) {
          source = yamlFormat.generate "lazyworktree.yaml" cfg.settings;
        };

        programs = {
          fish.functions.${cfg.shellWrapperName} = mkIf cfg.enableFishIntegration ''
            set -l tmp (mktemp -t lazyworktree.selection.XXXXXX)
            or return 1
            command lazyworktree --output-selection="$tmp" $argv
            set -l rc $status
            if test $rc -ne 0
                rm -f "$tmp"
                return $rc
            end
            if test -s "$tmp"
                set -l selected (cat "$tmp")
                if test -n "$selected" -a -d "$selected"
                    cd "$selected"
                end
            end
            rm -f "$tmp"
          '';
          bash.initExtra = mkIf cfg.enableBashIntegration ''
            function ${cfg.shellWrapperName}() {
              local tmp rc selected
              tmp="$(mktemp -t lazyworktree.selection.XXXXXX)" || return 1
              command lazyworktree --output-selection="$tmp" "$@"
              rc=$?
              if [ $rc -ne 0 ]; then
                rm -f "$tmp"
                return $rc
              fi
              if [ -s "$tmp" ]; then
                selected="$(cat "$tmp")"
                [ -n "$selected" ] && [ -d "$selected" ] && cd "$selected"
              fi
              rm -f "$tmp"
            }
          '';
          zsh.initContent = mkIf cfg.enableZshIntegration ''
            function ${cfg.shellWrapperName}() {
              local tmp rc selected
              tmp="$(mktemp -t lazyworktree.selection.XXXXXX)" || return 1
              command lazyworktree --output-selection="$tmp" "$@"
              rc=$?
              if [ $rc -ne 0 ]; then
                rm -f "$tmp"
                return $rc
              fi
              if [ -s "$tmp" ]; then
                selected="$(cat "$tmp")"
                [ -n "$selected" ] && [ -d "$selected" ] && cd "$selected"
              fi
              rm -f "$tmp"
            }
          '';
        };
      };
    };
}
