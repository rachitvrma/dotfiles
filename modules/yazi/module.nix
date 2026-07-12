let
  theme = {
    filetype = {
      rules = [
        {
          fg = "#89b482";
          mime = "image/*";
        }
        {
          fg = "#d8a657";
          mime = "{audio, video}/*";
        }
        {
          fg = "#a9b665";
          mime = "application/{pdf,doc,rtf}";
        }
        { mime = "application/"; }
        {
          fg = "#7daea3";
          url = "*/";
        }
        {
          fg = "#ddc7a1";
          mime = "*";
        }
      ];
    };
    help = {
      desc = {
        fg = "#ddc7a1";
      };
      footer = {
        bg = "#ddc7a1";
        fg = "#504945";
      };
      hovered = {
        bold = true;
        reversed = true;
      };
      on = {
        fg = "#89b482";
      };
      run = {
        fg = "#d3869b";
      };
    };
    indicator = {
      current = {
        reversed = true;
      };
      parent = {
        reversed = true;
      };
      preview = {
        underline = true;
      };
    };
    input = {
      border = {
        fg = "#7daea3";
      };
      selected = {
        bg = "#504945";
      };
    };
    mgr = {
      border_style = {
        fg = "#7daea3";
      };
      count_copied = {
        bg = "#a9b665";
        fg = "#202020";
      };
      count_cut = {
        bg = "#ea6962";
        fg = "#202020";
      };
      count_selected = {
        bg = "#d8a657";
        fg = "#202020";
      };
      cwd = {
        fg = "#89b482";
      };
      find_keyword = {
        bold = true;
        fg = "#d8a657";
      };
      find_position = {
        fg = "#d3869b";
      };
      marker_copied = {
        bg = "#a9b665";
        fg = "#a9b665";
      };
      marker_cut = {
        bg = "#ea6962";
        fg = "#ea6962";
      };
      marker_selected = {
        bg = "#d8a657";
        fg = "#d8a657";
      };
    };
    mode = {
      normal_alt = {
        bg = "#504945";
        fg = "#7daea3";
      };
      normal_main = {
        bg = "#7daea3";
        bold = true;
        fg = "#202020";
      };
      select_alt = {
        bg = "#504945";
        fg = "#d3869b";
      };
      select_main = {
        bg = "#d3869b";
        bold = true;
        fg = "#202020";
      };
      unset_alt = {
        bg = "#504945";
        fg = "#ea6962";
      };
      unset_main = {
        bg = "#ea6962";
        bold = true;
        fg = "#202020";
      };
    };
    notify = {
      title_error = {
        fg = "#ea6962";
      };
      title_info = {
        fg = "#89b482";
      };
      title_warn = {
        fg = "#d8a657";
      };
    };
    pick = {
      active = {
        fg = "#d3869b";
      };
      border = {
        fg = "#7daea3";
      };
      inactive = {
        fg = "#ddc7a1";
      };
    };
    status = {
      perm_exec = {
        fg = "#a9b665";
      };
      perm_read = {
        fg = "#d8a657";
      };
      perm_sep = {
        fg = "#89b482";
      };
      perm_type = {
        fg = "#7daea3";
      };
      perm_write = {
        fg = "#ea6962";
      };
      progress_error = {
        bg = "#202020";
        fg = "#ea6962";
      };
      progress_label = {
        bg = "#202020";
        fg = "#ddc7a1";
      };
      progress_normal = {
        bg = "#202020";
        fg = "#ddc7a1";
      };
    };
    tabs = {
      active = {
        bg = "#7daea3";
        fg = "#202020";
      };
      inactive = {
        bg = "#2a2827";
        fg = "#7daea3";
      };
    };
    task = {
      border = {
        fg = "#7daea3";
      };
      hovered = {
        bg = "#504945";
        fg = "#ddc7a1";
      };
      title = {
        fg = "#7daea3";
      };
    };
    which = {
      cand = {
        fg = "#89b482";
      };
      desc = {
        fg = "#ddc7a1";
      };
      mask = {
        bg = "#504945";
      };
      rest = {
        fg = "#bd6f3e";
      };
      separator_style = {
        fg = "#bdae93";
      };
    };
  };
in
{
  flake.nixosModules.yazi = {
    programs.yazi = {
      enable = true;
      settings = {
        inherit theme;
      };
    };
  };

  flake.homeModules.yazi = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      inherit theme;
      extraPackages = with pkgs; [ mediainfo ];
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
        };
      };
      initLua = ./init.lua;
    };
  };
}
