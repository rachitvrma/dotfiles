{
  flake.nixosModules.shell = {
    programs = {
      vivid.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableFishIntegration = true;
      };
    };
  };

  flake.homeModules.shell = {
    home = {
      shell = {
        enableFishIntegration = true;
        enableShellIntegration = true;
      };
    };
    programs = {
      nix-your-shell = {
        enable = true;
        enableFishIntegration = true;
        nix-output-monitor.enable = true;
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
        git = true;
        icons = "auto";
        extraOptions = [
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
      };

      ripgrep = {
        enable = true;
      };

      starship = {
        enable = true;
        enableFishIntegration = true;
        presets = [ "nerd-font-symbols" ];
      };
    };
  };
}
