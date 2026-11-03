# Laptop power management. Hibernation itself is host specific, see
# hosts/nixpavilion/_hibernation.nix.
{
  flake.nixosModules.power = {
    powerManagement.powertop.enable = true;

    services = {
      thermald.enable = true;
      power-profiles-daemon.enable = true;
      upower = {
        enable = true;
        usePercentageForPolicy = true;
        # Must stay above batsignal's thresholds (see services-user.nix:
        # warning 30%, critical 10%), otherwise the machine would act before
        # you are warned. Needs percentageLow > percentageCritical > percentageAction.
        percentageLow = 20;
        percentageCritical = 10;
        percentageAction = 5;
        criticalPowerAction = "PowerOff"; # hosts with working hibernation override this
      };
    };
  };
}
