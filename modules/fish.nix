{
  flake.nixosModules.fish = {
    programs.fish = {
      enable = true;
      useBabelfish = true;
    };
  };

  flake.homeModules.fish = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        function fish_greeting
            fastfetch --config examples/13.jsonc
        end
      '';
    };
  };
}
