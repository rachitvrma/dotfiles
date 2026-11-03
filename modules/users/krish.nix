{ me, ... }:
{
  flake = {
    nixosModules.krish = {
      users = {
        users.${me.username} = {
          isNormalUser = true;
          group = me.username;
          description = me.fullName;
          extraGroups = [
            "networkmanager"
            "wheel"
          ];
          # SECURITY: this is committed to a public repo. Change it with
          # `passwd` right after the first login (or move to hashedPasswordFile
          # with agenix).
          initialPassword = "1234";
        };
        groups.${me.username} = { };
      };
    };

    # Standalone home-manager module. Not wired into any host yet; use it with
    # flake.homeConfigurations or home-manager.nixosModules.home-manager.
    # homeModules.krish = {
    #   home = {
    #     username = me.username;
    #     homeDirectory = "/home/${me.username}";
    #     stateVersion = "26.05";
    #   };
    #   programs.home-manager.enable = true;
    # };
  };
}
