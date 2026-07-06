{
  flake.homeModules.fastfetch = {
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          type = "small";
        };
        display = {
          separator = " ";
        };
        modules = [
          {
            key = "╭─󰌢";
            keyColor = "green";
            type = "host";
          }
          {
            key = "├─󰻠";
            keyColor = "green";
            type = "cpu";
          }
          {
            key = "├─󰍛";
            keyColor = "green";
            type = "gpu";
          }
          {
            key = "├─";
            keyColor = "green";
            type = "disk";
          }
          {
            key = "├─󰑭";
            keyColor = "green";
            type = "memory";
          }
          {
            key = "├─󰓡";
            keyColor = "green";
            type = "swap";
          }
          {
            key = "├─󰍹";
            keyColor = "green";
            type = "display";
          }
          {
            key = "├─󰃞";
            keyColor = "green";
            type = "brightness";
          }
          {
            key = "├─";
            keyColor = "green";
            type = "battery";
          }
          {
            key = "├─";
            keyColor = "green";
            type = "poweradapter";
          }
          {
            key = "├─";
            keyColor = "green";
            type = "gamepad";
          }
          {
            key = "├─";
            keyColor = "green";
            type = "bluetooth";
          }
          {
            key = "╰─";
            keyColor = "green";
            type = "sound";
          }
          "break"
          {
            key = "╭─";
            keyColor = "yellow";
            type = "shell";
          }
          {
            key = "├─";
            keyColor = "yellow";
            type = "terminal";
          }
          {
            key = "├─";
            keyColor = "yellow";
            type = "terminalfont";
          }
          {
            key = "├─󰧨";
            keyColor = "yellow";
            type = "lm";
          }
          {
            key = "├─";
            keyColor = "yellow";
            type = "de";
          }
          {
            key = "├─";
            keyColor = "yellow";
            type = "wm";
          }
          {
            key = "├─󰉼";
            keyColor = "yellow";
            type = "theme";
          }
          {
            key = "├─󰀻";
            keyColor = "yellow";
            type = "icons";
          }
          {
            key = "╰─󱇘";
            keyColor = "yellow";
            type = "disk";
            folders = "/";
            format = "{create-time:10} ({days} days)";
          }
          "break"
          {
            format = "{user-name}@{host-name}";
            key = "╭─";
            keyColor = "blue";
            type = "title";
          }
          {
            key = "├─";
            keyColor = "blue";
            type = "os";
          }
          {
            key = "├─";
            keyColor = "blue";
            type = "kernel";
          }
          {
            key = "├─󰏖";
            keyColor = "blue";
            type = "packages";
          }
          {
            key = "├─󰅐";
            keyColor = "blue";
            type = "uptime";
          }
          {
            key = "├─󰝚";
            keyColor = "blue";
            type = "media";
          }
          {
            compact = true;
            key = "├─󰩟";
            keyColor = "blue";
            type = "localip";
          }
          {
            key = "├─󰩠";
            keyColor = "blue";
            timeout = 1000;
            type = "publicip";
          }
          {
            format = "{ssid}";
            key = "├─";
            keyColor = "blue";
            type = "wifi";
          }
          {
            key = "╰─";
            keyColor = "blue";
            type = "locale";
          }
        ];
      };

    };
  };
}
