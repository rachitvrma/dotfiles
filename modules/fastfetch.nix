{
  flake.homeModules.fastfetch = {
    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        display = {
          separator = " ";
        };
        logo = {
          padding = {
            top = 2;
            right = 6;
          };
          type = "auto";
          source = "~/.config/fastfetch/images/*";
          width = 30;
        };
        modules = [
          {
            key = "╭───────────╮";
            type = "custom";
          }
          {
            format = "{user-name}";
            key = "│ {#31} user    {#keys}│";
            type = "title";
          }
          {
            format = "{host-name}";
            key = "│ {#32}󰇅 hname   {#keys}│";
            type = "title";
          }
          {
            key = "│ {#33}󰅐 uptime  {#keys}│";
            type = "uptime";
          }
          {
            key = "│ {#34}{icon} distro  {#keys}│";
            type = "os";
          }
          {
            key = "│ {#35} kernel  {#keys}│";
            type = "kernel";
          }
          {
            key = "│ {#36}󰇄 desktop {#keys}│";
            type = "de";
          }
          {
            key = "│ {#31} term    {#keys}│";
            type = "terminal";
          }
          {
            key = "│ {#32} shell   {#keys}│";
            type = "shell";
          }
          {
            key = "│ {#33}󰃭 age     {#keys}│";
            text = "days=$(( ($(date +%s) - $(stat -c %W /)) / 86400 )); echo $days days";
            type = "command";
          }
          {
            folders = "/";
            key = "│ {#34}󰉉 disk    {#keys}│";
            type = "disk";
          }
          {
            key = "│ {#35} memory  {#keys}│";
            type = "memory";
          }
          {
            format = "{ipv4} ({ifname})";
            key = "│ {#36}󰩟 network {#keys}│";
            type = "localip";
          }
          {
            key = "├───────────┤";
            type = "custom";
          }
          {
            key = "│ {#39} colors  {#keys}│";
            symbol = "circle";
            type = "colors";
          }
          {
            key = "╰───────────╯";
            type = "custom";
          }
        ];
      };
    };
  };
}
