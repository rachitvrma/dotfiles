# Refer to https://wiki.nixos.org/wiki/Virt-manager
# when encountering problems.

# NOTE will encounter this on grabage collect.
# https://wiki.nixos.org/wiki/Virt-manager#Unable_to_find_'efi'_firmware
{
  flake.nixosModules.virtualisation = { pkgs, ... }: {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
        swtpm.enable = true;
      };
    };
    programs.virt-manager.enable = true;
    users.users.krish.extraGroups = [
      "libvirtd"
      "kvm"
    ];
    environment.systemPackages = with pkgs; [ dnsmasq ];
    networking.firewall.trustedInterfaces = [ "virbr0" ];
  };
}
