{
  flake.nixosModules.sound = { ... }: {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
    };
  };
}


