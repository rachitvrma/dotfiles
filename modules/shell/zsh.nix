{
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "nh os switch";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "HIST_IGNORE_ALL_DUPS"
      ];
    };
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [ zsh ];
  };
  flake.homeModules.zsh = { config, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;
      autosuggestion.enable = true;
      fastSyntaxHighlighting.enable = true;

      dirHashes = {
        # TODO: replace with xdg.userDirs
        docs = "${config.home.homeDirectory}/Documents";
        vids = "${config.home.homeDirectory}/Videos";
        dl = "${config.home.homeDirectory}/Downloads";
      };

      shellAliases = {
        ll = "ls -l";
        update = "nh os switch";
      };
      historySubstringSearch.enable = true;
      setOptions = [
        "INTERACTIVE_COMMENTS"
      ];
      history = {
        append = true;
        expireDuplicatesFirst = true;
        extended = true;
        findNoDups = true;
        size = 10000;
        ignoreAllDups = true;
        ignoreDups = true;
        saveNoDups = true;
        path = "$HOME/.zsh_history";
        ignorePatterns = [
          "rm *"
          "pkill *"
          "cp *"
        ];
      };

      # For faster performance
      # https://discourse.nixos.org/t/terminal-zsh-performance-issue-under-home-manager-help/55798/12
      completionInit = /* bash */ ''
        autoload -Uz compinit
        fpath=(''${(ou)fpath}) # Stable fpath order hence consistent cache hit.
        if [[ ! -s ''${ZDOTDIR:-$HOME}/.zcompdump || \
              /run/current-system/sw -nt ''${ZDOTDIR:-$HOME}/.zcompdump ]]; then
          compinit
          zcompile ''${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null
        else
          compinit -C
        fi
      '';
    };
  };
}
