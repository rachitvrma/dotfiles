{
  flake.nixosModules.sound = { pkgs, ... }: {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      wiremix
    ];
  };

  flake.homeModules.sound = { pkgs, ... }: {
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
    };
    home.packages = [ pkgs.pavucontrol ];
  };
}
