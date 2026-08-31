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
        glow
      ];
      plugins = {
        git = {
          package = pkgs.yaziPlugins.git;
          setup = true;
          settings = {
            order = 1500;
          };
        };
        faster-piper = {
          package = pkgs.nur.repos.adam0.yaziPlugins.faster-piper;
        };
        mediainfo = {
          package = pkgs.yaziPlugins.mediainfo;
        };
        vcs-files = {
          package = pkgs.yaziPlugins.vcs-files;
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

            # Faster-Piper
            {
              url = "*.md";
              # Use glow to see markdown
              run = ''faster-piper -- CLICOLOR_FORCE=1 glow -w=$w -- "$1"'';
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
          # cbz and cbr files don't open with zathura
          read = [
            {
              run = "zathura %s1";
              orphan = true;
              for = "unix";
            }
          ];

          # Use xdg-open as the default opener
          open = [
            {
              run = "xdg-open %s1";
              desc = "Open";
            }
          ];

          add-sub = [
            {
              desc = "Add sub to MPV";
              run = " printf \"sub-add '%%s'\\n\" %s1 | socat - /tmp/mpv.sock ";
            }
          ];

          # Change wallpaper using noctalia
          set-wallpaper = [
            {
              desc = "Set as wallpaper";
              for = "linux";
              run = "noctalia msg wallpaper-set %s1";
            }
          ];
        };
        open = {
          prepend_rules = [
            # Enable subtitles for the currently playing video in MPV
            {
              url = "*.{ass,srt,ssa,sty,sup,vtt}";
              use = [
                "add-sub"
                "edit"
              ];
            }
            # Use set-wallpaper as an opener for images
            {
              mime = "image/*";
              use = [
                "set-wallpaper"
                "open"
              ];
            }
            # Use the read rule for certain filetypes
            {
              url = "*.cbz";
              use = [
                "read"
                "reveal"
              ];
            }
            {
              url = "*.cbr";
              use = [
                "read"
                "reveal"
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
          {
            # VCS-files setup
            on = [
              "g"
              "C"
            ];
            run = "plugin vcs-files";
            desc = "Show Git file changes";
          }
          {
            # Move into a shell by pressing "!"
            on = [ "!" ];
            for = "unix";
            run = ''shell "$SHELL" --block'';
            desc = "Open $SHELL here";
          }
          {
            # Move to nixos configuration quickly
            on = [
              "g"
              "n"
            ];
            run = "cd ~/etc/nixos";
            desc = "Go to nixos configuration";
            for = "unix";
          }
        ];
      };
      initLua = ./init.lua;
    };
  };
}
