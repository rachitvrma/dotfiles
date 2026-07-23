{ self, ... }: {
  flake.overlays.qutebrowser = final: prev: {
    qutebrowser = prev.qutebrowser.override {
      enableWideVine = true;
      enableVulkan = true;
      withPdfReader = false;
    };
  };

  flake.nixosModules.qutebrowser = {
    nixpkgs.overlays = [ self.overlays.qutebrowser ];
  };

  flake.homeModules.qutebrowser = {
    programs.qutebrowser = {
      enable = true;
      settings = { };
    };
  };
}
