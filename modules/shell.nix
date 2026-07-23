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
      television = {
        enable = true;
        enableFishIntegration = true;
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

  flake.homeModules.shell = { pkgs, config, ... }: {
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
      packages = with pkgs; [
        figlet
        speedtest-cli
        trash-cli
      ];
      sessionVariables = {
        # Use the $XDG_NOTES_DIR as the ZK_NOTEBOOK_DIR
        ZK_NOTEBOOK_DIR = config.xdg.userDirs.extraConfig.NOTES;
      };
    };
    programs = {
      zk = {
        enable = true;
        settings = {
          notebook.dir = "${config.home.homeDirectory}/Notes"; # match XDG_NOTES_DIR
          note = {
            language = "en";
            default-title = "Untitled";
            filename = "{{id}}-{{slug title}}";
            extension = "md";
            id-charset = "alphanum";
            id-length = 4;
            id-case = "lower";
          };
        };
      };
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

      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
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

      television = {
        enable = true;
        enableFishIntegration = true;
        channels = {
          nixdots = {
            actions = {
              edit = {
                command = "if set -q EDITOR; and test -n \"$EDITOR\"; $EDITOR {}; else; vim {}; end";
                description = "Edit the selected nix config file";
                mode = "execute";
                shell = "fish";
              };
            };
            keybindings = {
              enter = "actions:edit";
            };
            metadata = {
              description = "A channel to select from your user's nixos config";
              name = "nixdots";
              requirements = [
                "fd"
                "bat"
              ];
            };
            preview = {
              command = "bat -n --color=always '{}'";
            };
            source = {
              command = "fd -t f . $HOME/etc/nixos";
            };
          };

        };
      };

      nix-search-tv = {
        enable = true;
        enableTelevisionIntegration = true;
      };

      zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
