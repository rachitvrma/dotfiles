{
  flake.nixosModules.android = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      android-tools
      scrcpy
    ];
  };
}
