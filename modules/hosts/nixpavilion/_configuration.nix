# Host specific settings for nixpavilion. Shared settings live in modules/*.nix.
{ pkgs, ... }:
{
  # This value determines the NixOS release from which the default settings
  # for stateful data (file locations, database versions) were taken. Leave it
  # at the release of the first install. Read the docs before changing it
  # (man configuration.nix or https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05";

  networking.hostName = "nixpavilion";

  programs = {
    vim.enable = true;
    nano.enable = false;
    gnupg = {
      dirmngr.enable = true;
      agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryPackage = pkgs.pinentry-emacs;
      };
    };
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      # Hide the boot menu; pressing any key at boot still opens it.
      timeout = 0;
    };

    # The initrd is always systemd-based in current nixpkgs (the scripted
    # initrd was removed), which is what the rd.* parameters below and
    # hibernation resume rely on.
    # See https://wiki.nixos.org/wiki/Plymouth
    plymouth.enable = true;
    consoleLogLevel = 3;

    kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.max_pool_percent=20" # max share of RAM zswap may use
      "zswap.shrinker_enabled=1" # shrink the pool proactively under memory pressure
      # "i915.enable_guc=3" # enabling xe creates problems in gaming

      # Plymouth
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    libinput.enable = true;
    # printing.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
      fileSystems = [ "/" ];
    };
  };

  # Host specific build limits
  nix.settings = {
    cores = 4;
    max-jobs = 1;
  };

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    intel-gpu-tools.enable = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
        libvpl
        vulkan-validation-layers
      ];
    };
  };

  environment = {
    systemPackages = [ pkgs.bluetui ];
    sessionVariables.LIBVA_DRIVER_NAME = "iHD"; # intel-media-driver
  };
}
