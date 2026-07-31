{
  flake.nixosModules.shell = {
    programs = {
      comma = {
        enable = true;
        enableZshIntegration = true;
      };
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
        enableZshIntegration = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      bat = {
        enable = true;
        settings = {
          italic-text = "always";
          pager = "less";
          paging = "never";
        };
      };
      vivid.enable = true;
    };
  };

  flake.homeModules.shell = { pkgs, config, ... }: {
    home = {
      shell = {
        enableZshIntegration = true;
        enableShellIntegration = true;
      };

      shellAliases = {
        ".." = "cd ..";
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
            extension = "md";
            id-charset = "alphanum";
            id-length = 4;
            id-case = "lower";
          };
        };
      };
      devenv = {
        enable = true;
        enableZshIntegration = true;
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
        };
      };

      tealdeer = {
        enable = true;
        settings.updates.auto_update = true;
      };

      nix-your-shell = {
        enable = true;
        enableZshIntegration = true;
        nix-output-monitor.enable = true;
      };

      carapace = {
        enable = true;
        enableZshIntegration = true;
      };

      fd.enable = true;

      eza = {
        enable = true;
        colors = "auto";
        enableZshIntegration = true;
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
        colorMode = "24-bit";
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
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
        enableZshIntegration = true;
        presets = [ "nerd-font-symbols" ];
        settings = {
          scan_timeout = 10;
          add_newline = true;
          command_timeout = 200;
        };
      };

      television = {
        enable = true;
        enableZshIntegration = true;
        extraPackages = with pkgs; [
          poppler-utils # for pdftotext command
          figlet # for figlet-fonts
        ];
        channels = {
          nixdots = {
            actions = {
              edit = {
                # FIXME: This is designed for fish shell, fix it to use zsh shell
                # command = "if set -q EDITOR; and test -n \"$EDITOR\"; $EDITOR {}; else; vim {}; end";
                description = "Edit the selected nix config file";
                mode = "execute";
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
        settings = {
          indexes = [
            "nixpkgs"
            "home-manager"
            "nixos"
            "nur"
            "noogle"
          ];
        };
      };

      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
