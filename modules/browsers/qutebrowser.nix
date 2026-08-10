{ self, ... }: {
  flake.overlays.qutebrowser = final: prev: {
    qutebrowser = prev.qutebrowser.override {
      enableWideVine = true;
      enableVulkan = true;
      withPdfReader = false;
    };
  };

  flake.nixosModules.qutebrowser = {
    nixpkgs.overlays = [ self.overlays.qutebrowser ];
  };

  flake.homeModules.qutebrowser = { pkgs, ... }: {
    programs.qutebrowser =
      let
        userscript_dir = pkgs.qutebrowser + "/share/qutebrowser/userscripts";
      in
      {
        enable = true;
        settings = {
          downloads = {
            position = "bottom";
          };
          editor = {
            command = [
              "nvim"
              "-f"
              "{file}"
              "-c"
              "normal {line}G{column0}l"
            ];
          };
          fileselect = {
            handler = "external";
            folder.command = [
              "kitty"
              "--class"
              "filechoose_yazi"
              "-e"
              "yazi"
              "--chooser-file={}"
            ];
            single_file.command = [
              "kitty"
              "--class"
              "filechoose_yazi"
              "-e"
              "yazi"
              "--chooser-file={}"
            ];
            multiple_files.command = [
              "kitty"
              "--class"
              "filechoose_yazi"
              "-e"
              "yazi"
              "--chooser-file={}"
            ];
          };
          content = {
            javascript.enabled = true;
            blocking.method = "both";
          };
          colors.webpage = {
            darkmode.enabled = true;
            preferred_color_scheme = "dark";
          };
        };
        aliases = {
          mpv = "spawn --userscript ${userscript_dir}/view_in_mpv";
        };

        searchEngines = {
          w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
          aw = "https://wiki.archlinux.org/?search={}";
          nw = "https://wiki.nixos.org/index.php?search={}";
          no = "https://search.nixos.org/options?channel=unstable&query={}&type=options";
          np = "https://search.nixos.org/packages?type=packages&query={}&channel=unstable";
          hm = "https://search.nixos.org/options?channel=unstable&query={}&source=home_manager&type=options";
          g = "https://www.google.com/search?hl=en&q={}";
          stylix = "https://nix-community.github.io/stylix/installation.html?search={}";
          lrc = "https://lrclib.net/search/{}";
          mb = "https://musicbrainz.org/search?query={}&type=artist&method=indexed";
          ytm = "https://music.youtube.com/search?q={}";
          rsslkup = "https://www.rsslookup.com/?url={}";
        };

        perDomainSettings = {
          "https://app.element.io".content.notifications.enabled = true;
          "https://claude.ai/new".content.notifications.enabled = true;
        };

        quickmarks = {
          github = "https://github.com/";
          github-notifications = "https://github.com/notifications?query=is%3Aunread";
          github-pr = "https://github.com/pulls/inbox";
          claude = "https://claude.ai/";
          news = "http://localhost:8080/"; # for miniflux
        };
      };
  };
}
