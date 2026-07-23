# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{self, inputs, ...}: {
  flake.nixosModules.hostMain =
    { pkgs, ... }:
    {
      imports = [
        # Import disko configuration
        inputs.disko.nixosModules.disko
        self.diskoConfigurations.hostMain
      ];

      programs = {
        vim.enable = true;
        nano.enable = false;
      };
      # Bootloader.
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        plymouth = {
          enable = true;
          theme = "breeze";
        };

        kernelParams = [
          "quiet"
          "splash"
          "zswap.enabled=1" # enables zswap
          "zswap.compressor=zstd" # compression algorithm
          "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
          "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
          # "i915.enable_guc=3" # Enabling xe now creates some problems in gaming
        ];
        kernelPackages = pkgs.linuxPackages_latest;
      };

      networking.hostName = "nixpavilion"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      services = {
        # Enable touchpad support (enabled default in most desktopManager).
        libinput.enable = true;
        # Enable CUPS to print documents.
        # printing.enable = true;
        # Enable btrfs autoscrub service for btrfs managed machines
        btrfs.autoScrub = {
          enable = true;
          interval = "weekly";
          fileSystems = [ "/" ];
        };
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # host specific cpu settings
      nix.settings = {
        cores = 8;
        max-jobs = 1;
      };

      hardware = {
        bluetooth.enable = true;
        enableRedistributableFirmware = true;
        intel-gpu-tools.enable = true;
        graphics = {
          enable = true;

          package = pkgs.mesa;
          extraPackages = with pkgs; [
            intel-media-driver
            intel-compute-runtime
            vpl-gpu-rt
            vulkan-loader
            vulkan-validation-layers
            libvpl
          ];
        };
      };
      environment.systemPackages = with pkgs; [ bluetui ];
    };
}
