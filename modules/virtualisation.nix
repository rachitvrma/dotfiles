# Refer to https://wiki.nixos.org/wiki/Virt-manager
# when encountering problems.
#
# NOTE: you will hit this after a garbage collect.
# https://wiki.nixos.org/wiki/Virt-manager#Unable_to_find_'efi'_firmware
{ me, ... }:
{
  flake.nixosModules.virtualisation =
    { pkgs, ... }:
    {
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
      users.users.${me.username}.extraGroups = [
        "libvirtd"
        "kvm"
      ];
      environment.systemPackages = [ pkgs.dnsmasq ];
      networking.firewall.trustedInterfaces = [ "virbr0" ];
    };
}
