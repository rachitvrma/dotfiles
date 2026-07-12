{
  flake.nixosModules.waybar = {
    programs.waybar = {
      enable = true;
    };
  };

  flake.homeModules.waybar = {
    programs.waybar = {
      style = builtins.readFile ./style.css;
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 25;

          modules-center = [
            "hyprland/workspaces"
            "hyprland/mode"
          ];
          modules-right = [
            "network"
            "upower"
            "brightness"
            "clock"
            "wireplumber#sink"
          ];
          modules-left = [
            "idle_inhibitor"
          ];

          network = {
            format = "{ifname}";
            format-disconnected = " ";
            format-ethernet = " ";
            format-wifi = " ";
            interface = "wlan0";
            max-length = 50;
            tooltip-format = "{ifname}";
            tooltip-format-disconnected = "Disconnected";
            tooltip-format-ethernet = " {ifname}";
            tooltip-format-wifi = " {essid} ({signalStrength}%)";
          };

          upower = {
            icon-size = 20;
            hide-if-empty = true;
            tooltip = true;
            tooltip-spacing = 20;
          };

          wireplumber = {
            format = "{volume}% {icon}";
          };
          "wireplumber#sink" = {
            format = "{icon} {volume}%";
            format-icons = [
              ""
              ""
              ""
            ];
            format-muted = "󰅶";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            scroll-step = 5;
          };
          "wireplumber#source" = {
            format = " {volume}%";
            format-muted = " ";
            node-type = "Audio/Source";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            scroll-step = 5;
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          clock = {
            # TODO: Get a full calendar over here.
            format = "󰥔 {:%I:%M %p}";
            format-alt = "󰃰 {:%A, %B %d, %Y (%R)}";
          };
        };
      };
    };
  };
}
