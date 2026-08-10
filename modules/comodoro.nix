# FIXME: Not working
{
  flake.homeModules.comodoro = {
    programs = {
      comodoro = {
        enable = false;
        settings = {
          default = {
            cycles = [
              {
                name = "Work";
                duration = 1500;
              }
              {
                name = "Rest";
                duration = 300;
              }
            ];

            tcp-host = "localhost";
            tcp-port = 1234;

            on-server-start = "echo server started";
            on-timer-stop = "echo timer stopped";
            on-work-begin = "echo work cycle began";
          };
        };
      };
    };
    services = {
      comodoro = {
        enable = false;
        protocols = [ "tcp" ];
        preset = "default";
      };
    };
  };
}
