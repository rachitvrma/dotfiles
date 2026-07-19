{
  flake.homeModules.newsboat = { pkgs, ... }: {
    programs.newsboat = {
      enable = true;
      autoVacuum.enable = true;
      autoReload = true;
      reloadTime = 30;

      autoFetchArticles = {
        enable = true;
        onCalendar = "*:0/30";
      };

      maxItems = 100;
      browser = "${pkgs.xdg-utils}/bin/xdg-open";

      urls = [
        {
          url = "https://discourse.nixos.org/latest.rss";
          tags = [ "nix" ];
          title = "NixOS Discourse";
        }
        {
          url = "https://discourse.nixos.org/c/announcements/8.rss";
          tags = [ "nix" ];
          title = "NixOS Announcements";
        }
        {
          url = "https://github.com/neovim/neovim/releases.atom";
          tags = [ "editor" ];
          title = "Neovim Releases";
        }
        {
          url = "https://dotfyle.com/neovim/plugins/rss.xml";
          tags = [ "editor" ];
          title = "Neovim Plugins";
        }
        {
          url = "https://dotfyle.com/this-week-in-neovim/rss.xml";
          tags = [ "editor" ];
          title = "This Week in Neovim";
        }
        {
          url = "https://neovim.io/news.xml";
          tags = [ "editor" ];
          title = "Neovim News";
        }
        {
          url = "https://nvim-mini.org/blog/index.xml";
          tags = [ "editor" ];
          title = "Mini.Nvim Blog";
        }

        {
          url = "https://drewdevault.com/blog/index.xml";
          tags = [
            "wayland"
            "linux"
          ];
          title = "Drew DeVault";
        }
        {
          url = "https://www.redhat.com/en/rss/blog";
          tags = [ "linux" ];
          title = "Red Hat Blog";
        }
        {
          url = "https://fedoramagazine.org/feed/";
          tags = [ "linux" ];
          title = "Fedora Magazine";
        }
        {
          url = "https://www.freecodecamp.org/news/rss";
          title = "FreeCodeCamp News";
        }
        {
          url = "https://krebsonsecurity.com/feed/";
          tags = [ "security" ];
          title = "Krebs on Security";
        }
        {
          url = "https://feeds.feedburner.com/TheHackersNews";
          tags = [ "security" ];
          title = "The Hacker News";
        }
        {
          url = "https://simonwillison.net/atom/everything/";
          tags = [ "ai" ];
          title = "Simon Willison";
        }
      ];

      queries = {
        "security" = ''tags # "security"'';
        "today" = "age between 0:1";
      };

      extraConfig = ''
        color listnormal         color7  default        # #d4be98 fg, default bg
        color listnormal_unread  color6  default   bold  # #89b482 fg, bold, default bg
        color listfocus          color5  color0    bold  # #d3869b on #665c54
        color listfocus_unread   color5  color0    bold  # same focus style, still bold-marked as unread
        color info               color7  color0    bold  # #d4be98 on #665c54
        color article            color7  default

        bind-key j down
        bind-key k up
        bind-key J next-feed
        bind-key K prev-feed
        bind-key g home
        bind-key G end

        confirm-exit yes
        show-read-feeds yes
        cleanup-on-quit yes
      '';
    };
  };
}
