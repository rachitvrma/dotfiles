{ inputs, ... }: {
  flake.nixosModules.agenix = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      inputs.agenix.packages.${stdenv.hostPlatform.system}.default
    ];
    imports = [
      inputs.agenix.nixosModules.default
    ];
  };
  flake.homeModules.agenix = { ... }: {
    imports = [
      inputs.agenix.homeManagerModules.default
    ];
    age = {
      secrets = {
        ytmusic-client-id.file = ./secrets/ytmusic-client-id.age;
        ytmusic-client-secret.file = ./secrets/ytmusic-client-secret.age;
      };
    };
  };
}
