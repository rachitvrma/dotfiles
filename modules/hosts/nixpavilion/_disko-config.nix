{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # Interactive passphrase prompt. For unattended installs use passwordFile.
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "nixos"
                    "-f"
                  ];
                  subvolumes =
                    let
                      mountOptions = [
                        "compress=zstd"
                        "ssd"
                        "space_cache=v2"
                        "noatime"
                        "discard=async"
                      ];
                    in
                    {
                      "/root" = {
                        mountpoint = "/";
                        inherit mountOptions;
                      };
                      "/home" = {
                        mountpoint = "/home";
                        inherit mountOptions;
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        inherit mountOptions;
                      };
                      "/nix/store" = {
                        mountpoint = "/nix/store";
                        inherit mountOptions;
                      };
                      # Swapfile for hibernation. disko creates it with
                      # `btrfs filesystem mkswapfile` (NOCOW, uncompressed), so
                      # this subvolume must not be snapshotted.
                      # Size: RAM (16 GiB) + headroom for regular swapping.
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        mountOptions = [ "noatime" ];
                        swap.swapfile.size = "24G";
                      };
                    };
                };
              };
            };
          };
        };
      };
    };
  };
}


