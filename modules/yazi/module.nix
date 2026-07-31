{
  flake.nixosModules.yazi = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
    };
  };

  flake.homeModules.yazi = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
      enableZshIntegration = true;
      extraPackages = with pkgs; [
        mediainfo
        socat
      ];
      plugins = {
        git = {
          package = pkgs.yaziPlugins.git;
          setup = true;
          settings = {
            order = 1500;
          };
        };
        mediainfo = {
          package = pkgs.yaziPlugins.mediainfo;
        };
      };
      settings = {
        plugin = {
          prepend_preloaders = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }
            {
              mime = "application/{subrip,postscript,illustrator,dvb.ait,vnd.adobe.illustrator,eps}";
              run = "mediainfo";
            }
            {
              run = "mediainfo";
              url = "*.{ai,eps,ait}";
            }
          ];
          prepend_previewers = [
            {
              mime = "{audio,video,image}/*";
              run = "mediainfo";
            }
            {
              mime = "application/{subrip,postscript,illustrator,dvb.ait,vnd.adobe.illustrator,eps}";
              run = "mediainfo";
            }
            {
              run = "mediainfo";
              url = "*.{ai,eps,ait}";
            }
          ];
        };

        tasks = {
          image_alloc = 1073741824;
        };
        log = {
          enabled = false;
        };
        mgr = {
          show_hidden = false;
          linemode = "size_and_mtime";
          ratio = [
            1
            4
            3
          ];
          scrolloff = 200;
          show_dir_first = true;
          sort_by = "natural";
          sort_reverse = false;
          sort_sensitive = true;
          # previewer settings
          preview = {
            image_filter = "lanczos3";
            image_quality = 80;
            max_height = 900;
            max_width = 600;
            tab_size = 1;
            ueberzug_offset = [
              0
              0
              0
              0
            ];
            ueberzug_scale = 1;
          };
          tasks = {
            bizarre_retry = 5;
            macro_workers = 10;
            micro_workers = 5;
          };
        };
        # Plugin settings
        plugin = {
          prepend_fetchers = [
            # git.yazi {{{
            {
              url = "*";
              run = "git";
              group = "git";
            }
            {
              url = "*/";
              run = "git";
              group = "git";
            }
            # }}} git.yazi
          ];
        };
        # The opener.
        opener = {
          open = [
            {
              run = "xdg-open %s";
              desc = "Open";
            }
          ];
          add-sub = [
            {
              desc = "Add sub to MPV";
              run = " printf \"sub-add '%%s'\\n\" %s1 | socat - /tmp/mpv.sock ";
            }
          ];
        };
        open = {
          prepend_rules = [
            {
              url = "*.{ass,srt,ssa,sty,sup,vtt}";
              use = [
                "add-sub"
                "edit"
              ];
            }
          ];
        };
      };
      keymap = {
        mgr.prepend_keymap = [
          {
            # cd back to the root of the current Git repository
            on = [
              "g"
              "r"
            ];
            run = ''shell -- ya emit cd "$(git rev-parse --show-toplevel)"'';
          }
        ];
      };
      initLua = ./init.lua;
    };
  };
}
