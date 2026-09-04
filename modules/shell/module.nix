{
  flake.nixosModules.shell = {
    programs = {
      comma = {
        enable = true;
        enableZshIntegration = true;
      };
      direnv = {
        enable = true;
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

  flake.homeModules.shell = { pkgs, ... }: {
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
        sl = "sl -dFGl";
      };

      packages = with pkgs; [
        figlet
        sl
        speedtest-cli
        # See the systemd service and timer that cleans trash every 30 days
        trash-cli
        jdupes
        gdu
      ];
    };
    programs = {
      pay-respects = {
        # TODO: Configure this.
        enable = true;
        enableZshIntegration = true;
      };
      direnv = {
        enable = true;
      };
      clock-rs = {
        enable = true;
        settings = {
          general = {
            color = "magenta";
            interval = 250;
            blink = true;
            bold = true;
          };
          position = {
            horizontal = "center";
            vertical = "center";
          };
          date = {
            fmt = "%A, %B %d, %Y";
            use_12h = true;
            utc = false; # Display the system time.
            hide_seconds = false;
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

      television = {
        enable = true;
        enableZshIntegration = true;
        extraPackages = with pkgs; [
          poppler-utils # for pdftotext command
          figlet # for figlet-fonts
        ];
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

    # Systemd settings to clean out trash regularly
    systemd.user = {
      services.trash-empty = {
        Unit.Description = "Empty trash older than 30 days";
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.trash-cli}/bin/trash-empty 30";
        };
      };
      timers.trash-empty = {
        Unit.Description = "Empty trash older than 30 days daily";
        Timer = {
          OnCalendar = "daily";
          Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
  };
}
