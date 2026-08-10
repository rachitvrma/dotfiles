{
  flake = {
    nixosModules.starship = {
      programs.starship = {
        enable = true;
        transientPrompt.enable = true;
        settings = {
          scan_timeout = 10;
          add_newline = true;
          command_timeout = 200;
        };
      };
    };
    homeModules.starship = { lib, ... }: {
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = lib.mkAfter {
          "$schema" = "https://starship.rs/config-schema.json";
          add_newline = true;
          bun = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          c = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = " ";
          };
          character = {
            disabled = false;
            error_symbol = "[❯](bold fg:red)";
            success_symbol = "[❯](bold fg:green)";
            vimcmd_replace_one_symbol = "[❮](bold fg:brown)";
            vimcmd_replace_symbol = "[❮](bold fg:brown)";
            vimcmd_symbol = "[❮](bold fg:green)";
            vimcmd_visual_symbol = "[❮](bold fg:yellow)";
          };
          cmd_duration = {
            disabled = false;
            format = " in $duration ";
            min_time_to_notify = 45000;
            show_milliseconds = true;
            show_notifications = true;
            style = "bg:brown";
          };
          command_timeout = 200;
          conda = {
            format = "[$symbol$environment ]($style)";
            ignore_base = false;
            style = "fg:black bg:cyan";
            symbol = "  ";
          };
          directory = {
            format = "[ $path ]($style)";
            style = "bg:red fg:black";
            substitutions = {
              Developer = "󰲋 ";
              Documents = "󰈙 ";
              Downloads = " ";
              Music = "󰝚 ";
              Pictures = " ";
            };
            truncation_length = 3;
            truncation_symbol = "…/";
          };
          docker_context = {
            format = "[[ $symbol( $context) ](fg:black bg:cyan)]($style)";
            style = "bg:cyan";
            symbol = "";
          };
          format = "[](blue)$os$username[](bg:red fg:blue)$directory[](bg:yellow fg:red)$git_branch$git_status[](fg:yellow bg:green)$c$rust$golang$nodejs$bun$php$java$kotlin$haskell$python[](fg:green bg:brown)$conda[](fg:brown bg:cyan)$time[ ](fg:cyan)$cmd_duration$line_break$character";
          git_branch = {
            format = "[[ $symbol $branch ](fg:black bg:yellow)]($style)";
            style = "bg:yellow";
            symbol = "";
          };
          git_status = {
            format = "[[($all_status$ahead_behind )](fg:black bg:yellow)]($style)";
            style = "bg:yellow";
          };
          golang = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          haskell = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          java = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = " ";
          };
          kotlin = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          line_break = {
            disabled = false;
          };
          nodejs = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          os = {
            disabled = false;
            style = "bg:blue fg:black";
            symbols = {
              AOSC = "";
              Alpine = "";
              Amazon = "";
              Android = "";
              Arch = "󰣇";
              Artix = "󰣇";
              CentOS = "";
              Debian = "󰣚";
              Fedora = "󰣛";
              Gentoo = "󰣨";
              Linux = "󰌽";
              Macos = "󰀵";
              Manjaro = "";
              Mint = "󰣭";
              NixOS = "";
              Raspbian = "󰐿";
              RedHatEnterprise = "󱄛";
              Redhat = "󱄛";
              SUSE = "";
              Ubuntu = "󰕈";
              Windows = "";
            };
          };
          php = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          python = {
            format = "[[ $symbol( $version)(\\(#$virtualenv\\)) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          rust = {
            format = "[[ $symbol( $version) ](fg:black bg:green)]($style)";
            style = "bg:green";
            symbol = "";
          };
          scan_timeout = 10;
          time = {
            disabled = false;
            format = "[[  $time ](fg:black bg:cyan)]($style)";
            style = "bg:brown";
            time_format = "%R";
          };
          username = {
            format = "[ $user]($style)";
            show_always = true;
            style_root = "bg:blue fg:black";
            style_user = "bg:blue fg:black";
          };
        };
      };
    };
  };
}
