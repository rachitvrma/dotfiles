{
  flake.nixosModules.services-user =
    { lib, pkgs, ... }:
    {
      systemd.user = {
        services = {
          trash-empty = {
            description = "Empty trash older than 30 days";
            serviceConfig = {
              Type = "oneshot";
              # -f skips the confirmation prompt, which nothing could answer
              # when started from a timer.
              ExecStart = "${lib.getExe' pkgs.trash-cli "trash-empty"} -f 30";
            };
          };

          aria2 = {
            description = "Aria2c daemon";
            documentation = [ "man:aria2c(1)" ];
            wantedBy = [ "default.target" ];
            serviceConfig = {
              ExecStartPre = [
                "${pkgs.coreutils}/bin/mkdir -p %h/.config/aria2"
                "${pkgs.coreutils}/bin/touch %h/.config/aria2/session.lock"
              ];
              # config: stow/aria2
              ExecStart = "${lib.getExe pkgs.aria2} --enable-rpc";
              Restart = "on-failure";
            };
          };

          udiskie = {
            description = "udiskie mount daemon";
            after = [ "graphical-session.target" ];
            partOf = [ "graphical-session.target" ];
            wantedBy = [ "graphical-session.target" ];
            serviceConfig = {
              # --appindicator: StatusNotifierItem tray icon
              ExecStart = "${lib.getExe pkgs.udiskie} --appindicator";
              Restart = "on-failure";
            };
          };

          batsignal = {
            description = "batsignal - battery monitor daemon";
            after = [ "graphical-session.target" ];
            partOf = [ "graphical-session.target" ];
            wantedBy = [ "graphical-session.target" ];
            serviceConfig = {
              Type = "simple";
              ExecStart = "${lib.getExe pkgs.batsignal} -c 10 -w 30 -f 97";
              Restart = "on-failure";
              RestartSec = 1;
            };
          };
        };

        timers.trash-empty = {
          description = "Empty trash older than 30 days daily";
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
          };
        };
      };
    };
}
