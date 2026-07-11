{
  flake.nixosModules.shell = {
    programs = {
      starship = {
        enable = true;
        transientPrompt.enable = true;
        settings = {
          scan_timeout = 10;
          add_newline = true;
          command_timeout = 200;
        };
      };
      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      bat = {
        enable = true;
        settings = {
          italic-text = "always";
          pager = "less";
          paging = "never";
          theme = "gruvbox-dark";
        };
      };
      vivid.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };
    };
  };

  flake.homeModules.shell = { pkgs, ... }: {
    home = {
      shell = {
        enableFishIntegration = true;
        enableShellIntegration = true;
      };

      shellAliases = {
        ff = "${pkgs.fastfetch}/bin/fastfetch";
        nos = "nh os switch";
        nca = "nh clean all";
        cat = "bat --paging=never";
      };
    };
    programs = {
      jq.enable = true;
      bat = {
        enable = true;
        config = {
          map-syntax = [
            "*.ino:C++"
            ".ignore:Git Ignore"
            "*.jenkinsfile:Groovy"
            "*.props:Java Properties"
          ];
          pager = "less -FR";
          theme = "gruvbox-dark";
        };
      };

      nix-your-shell = {
        enable = true;
        enableFishIntegration = true;
        nix-output-monitor.enable = true;
      };

      carapace = {
        enable = true;
        enableFishIntegration = true;
      };

      direnv = {
        enable = true;
        enableFishIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };

      fd.enable = true;

      eza = {
        enable = true;
        colors = "auto";
        enableFishIntegration = true;
        git = false; # Takes really long to load big git repos
        icons = "auto";
        extraOptions = [
          # "--git-repos" # Takes too long to load on big repos
          "--group-directories-first"
          "--header"
        ];
      };

      vivid = {
        enable = true;
        activeTheme = "gruvbox-dark-hard";
        colorMode = "24-bit";
        enableFishIntegration = true;
      };

      fzf = {
        enable = true;
        enableFishIntegration = true;
        defaultOptions = [
          "--height 40%"
          "--prompt ⟫"
        ];
      };

      ripgrep = {
        enable = true;
      };

      starship = {
        enable = true;
        enableFishIntegration = true;
        presets = [ "nerd-font-symbols" ];
        settings = {
          scan_timeout = 10;
          add_newline = true;
          command_timeout = 200;
        };
      };

      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
