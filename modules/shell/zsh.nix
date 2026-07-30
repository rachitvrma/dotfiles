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
  flake.homeModules.zsh = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "nh os switch";
      };
      history = {
        size = 10000;
        ignoreAllDups = true;
        path = "$HOME/.zsh_history";
        ignorePatterns = [
          "rm *"
          "pkill *"
          "cp *"
        ];
      };

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
