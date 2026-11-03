{ inputs, me, ... }:
{
  flake.nixosModules.agenix =
    { pkgs, ... }:
    {
      imports = [ inputs.agenix.nixosModules.default ];

      environment.systemPackages = [
        inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      # Secrets are encrypted to the user's ssh key (see secrets/secrets.nix).
      age.identityPaths = [ "/home/${me.username}/.ssh/id_ed25519" ];

      # Declare a secret once something consumes it:
      # age.secrets.ytmusic-client-id = {
      #   file = ./secrets/ytmusic-client-id.age;
      #   owner = me.username;
      # };
      # age.secrets.ytmusic-client-secret = {
      #   file = ./secrets/ytmusic-client-secret.age;
      #   owner = me.username;
      # };
    };
}
