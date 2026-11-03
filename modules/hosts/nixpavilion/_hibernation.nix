# Hibernation (suspend to disk) on the btrfs swapfile declared in
# _disko-config.nix (/.swapvol/swapfile, inside the LUKS container).
#
# Two ways for the kernel to find the hibernation image:
#
# 1. resumeOffset = null (default): nothing is passed on the kernel command
#    line. systemd records the swapfile's location in the EFI variable
#    HibernateLocation when it hibernates, and systemd-hibernate-resume (in the
#    systemd initrd) reads it back. Needs a UEFI boot,
#    which this machine has.
# 2. resumeOffset = <number>: classic `resume=` + `resume_offset=`. Use it if
#    (1) does not resume. Get the number with `just resume-offset` after the
#    swapfile exists, then rebuild.
{ lib, ... }:
let
  resumeOffset = null;
in
{
  boot.resumeDevice = lib.mkIf (resumeOffset != null) "/dev/mapper/crypted";
  boot.kernelParams = lib.optional (resumeOffset != null) "resume_offset=${toString resumeOffset}";

  # Close the lid: suspend first, hibernate after two hours (the battery then
  # lasts days instead of hours). Delete these two blocks to keep plain suspend.
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "suspend";
  };
  systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";

  # Hibernate instead of powering off when the battery is critical.
  services.upower.criticalPowerAction = lib.mkForce "Hibernate";
}
