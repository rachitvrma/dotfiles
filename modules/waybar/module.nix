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
            "sway/workspaces"
            "sway/mode"
          ];
          modules-right = [
            "battery"
            "brightness"
            "clock"
            "wireplumber"
          ];
          modules-left = [
            "idle_inhibit"
          ];
          wireplumber = {
            format = "{volume}%";

          };

          "wireplumber#sink" = {
            format = "{volume}% {icon}";
            format-icons = [
              ""
              ""
              ""
            ];
            format-muted = "󰅶";
            # on-click = "helvum";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            scroll-step = 5;
          };
          "wireplumber#source" = {
            format = "{volume}% ";
            format-muted = "";
            node-type = "Audio/Source";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            scroll-step = 5;
          };
        };
      };
    };
  };
}
