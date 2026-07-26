# use https://podcastindex.org/ to search for podcasts and their RSS feeds.
{
  flake.homeModules.newsboat = { ... }: {
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
      browser = "\"w3m %u\"";

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
          url = "https://ianthehenry.com/feed.xml";
          tags = [ "nix" ];
          title = "Ian Henry";
        }

        # Editor
        {
          url = "https://github.com/neovim/neovim/releases.atom";
          tags = [
            "editor"
            "nvim"
          ];
          title = "Neovim Releases";
        }
        {
          url = "https://dotfyle.com/neovim/plugins/rss.xml";
          tags = [
            "editor"
            "nvim"
          ];
          title = "Neovim Plugins";
        }
        {
          url = "https://dotfyle.com/this-week-in-neovim/rss.xml";
          tags = [
            "editor"
            "nvim"
          ];
          title = "This Week in Neovim";
        }
        {
          url = "https://neovim.io/news.xml";
          tags = [
            "editor"
            "nvim"
          ];
          title = "Neovim News";
        }
        {
          url = "https://nvim-mini.org/blog/index.xml";
          tags = [
            "editor"
            "nvim"
          ];
          title = "Mini.Nvim Blog";
        }

        # Linux
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
          url = "https://www.freecodecamp.org/news/tag/blog/rss/";
          title = "FreeCodeCamp Blog";
        }
        {
          url = "https://www.freecodecamp.org/news/tag/programming-blogs/rss/";
          title = "FreeCodeCamp Programming Blogs";
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

        # Podcasts
        {
          url = "https://api.substack.com/feed/podcast/4064027.rss";
          tags = [ "podcasts" ];
          title = "Amen Podcasts";
        }
        {
          url = "https://feeds.castos.com/41z28";
          tags = [ "podcasts" ];
          title = "BibleThinker";
        }

        {
          url = "https://anchor.fm/s/f5347ab0/podcast/rss";
          tags = [ "podcasts" ];
          title = "Raj Shamani";
        }
      ];

      queries = {
        "security" = ''tags # "security"'';
        "today" = "age between 0:1";
        "podcasts" = ''tags # "podcasts"'';
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

        download-path "~/Downloads/podcasts/%n/"
        download-filename-format "%F-%t.%e"
        max-downloads 3
        player "mpv --no-video"
      '';
    };
  };
}
