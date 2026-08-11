# NOTE: Read the option information before changing/adding/modifying any setting here.
# It's important because this module has a lot of if-else stuff, that changes the target paths where links are made.
# So be careful about it.
{
  flake.homeModules.w3m = { config, pkgs, ... }: {
    programs.w3m = {
      enable = true;
      settings = {
        history_size = 1000;
        download_action_type = "SAVE";
        image_scale = 100;
        ssl_verify_server = 1;
        ssl_ca_path = "/etc/ssl/certs";
        close_tab_back = 1;
        auto_uncompress = 1;
        inline_img_protocol = 4;
        extbrowser = "firefox";
        wrap_search = 1;
        ignorecase_search = 1;

        urimethodmap = "${config.xdg.configHome}/w3m/urimethodmap";
        cgi_bin = "${config.xdg.configHome}/w3m/cgi-bin";
        siteconf_file = "${config.xdg.configHome}/w3m/siteconf";
        tabstop = 4;
      };

      extraPackages = with pkgs; [
        rdrview
      ];

      # Most are picked from ArchWiki article on w3m
      siteconf = [
        {
          url = "m!^https?://([a-z]+\.)?twitter\.com/!";
          preferences = [ "substitute_url \"https://nitter.net/\"" ];
        }
        {
          url = "m!^https?://([a-z]+\.)?reddit\.com/!";
          preferences = [ "substitute_url \"https://safereddit.com/\"" ];
        }
        {
          url = "m!^https?://([a-z]+\.)?imgur\.com/!";
          preferences = [ "substitute_url \"https://rimgo.pussthecat.org/\"" ];
        }
        {
          url = "m!^https?://([a-z]+\.)?wikipedia\.com/!";
          preferences = [ "substitute_url \"https://wl.vern.cc/\"" ];
        }
        {
          url = "https://www.youtube.com/ exact";
          preferences = [ "substitute_url \"file:/cgi-bin/video.cgi?\"" ];
        }
        {
          url = "https://stackoverflow.com/ exact";
          preferences = [ "substitute_url \"https://ao.bloatcat.tk/\"" ];
        }
        {
          url = "https://www.reuters.com/ exact";
          preferences = [ "substitute_url \"https://neuters.de/\"" ];
        }
        {
          url = "https://fandom.com/ exact";
          preferences = [ "substitute_url \"https://breezewiki.pussthecat.org/\"" ];
        }
        {
          url = "https://medium.com/ exact";
          preferences = [ "substitute_url \"https://scribe.rip/\"" ];
        }
        {
          url = "https://web.archive.org/ exact";
          preferences = [ "substitute_url \"https://wayback-classic.net/\"" ];
        }
      ];

      # Taken from ArchWiki again
      bindings = {
        "R" =
          "COMMAND \"READ_SHELL 'rdrview $W3M_URL -H 2> /dev/null 1> /tmp/readable.html' ; LOAD /tmp/readable.html\"";
        "i" = "COMMAND \"SET_OPTION display_image=toggle ; RESHAPE\"";
      };
    };
  };
}
