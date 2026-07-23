{
  flake.nixosModules.krish = { pkgs, ... }: {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."krish" = {
      isNormalUser = true;
      description = "Rachit Kumar Verma";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
      initialPassword = "1234";
    };

    programs.fish.enable = true;
  };

  flake.homeModules.krish = {
    home = {
      username = "krish";
      homeDirectory = "/home/krish";
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
}
