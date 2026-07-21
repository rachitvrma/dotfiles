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

        set -g fish_key_bindings fish_vi_key_bindings
      '';

      shellAbbrs = {
        lsg = "ls -al --git";
      };
    };
  };
}
