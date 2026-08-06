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
      stylix.targets.starship.enable = false;
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        presets = [ "catppuccin-powerline" ];
        settings = lib.mkAfter {
          add_newline = true;
          command_timeout = 200;
          scan_timeout = 10;
          os = {
            symbols = {
              NixOS = "";
            };
          };
          line_break.disabled = false;
        };
      };
    };
  };
}
