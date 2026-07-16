{
  flake.homeModules.multimedia = { pkgs, config, ... }: {
    home = {
      packages = with pkgs; [
        ffmpeg-full
        # used for album art embedding
        (python3.withPackages (ps: with ps; [ mutagen ]))
        kew
        lrcget
      ];
      # Use socket for MPD connection, otherwise RMPC doesn't allow youtube playback.
      sessionVariables.MPD_HOST = "$XDG_RUNTIME_DIR/mpd/socket";
    };

    programs = {
      beets = {
        enable = true;
        settings = {
          directory = config.xdg.userDirs.music;
          library = "${config.xdg.dataHome}/beets/library.db";
          plugins = [
            "duplicates"
            "embedart"
            "fetchart"
            "ftintitle"
            "info"
            "lastgenre"
            "missing"
            "musicbrainz"
            "replaygain"
            "scrub"
          ];
          import = {
            move = true;
            write = true;
            resume = "ask";
            incremental = true;
          };
          paths = {
            default = "$albumartist/$album ($year)/$track - $title";
            singleton = "Singles/$artist/$title";
            comp = "Compilations/$album/$track - $title";
          };
          replaygain.backend = "ffmpeg";
        };
      };
      # For videos/music
      mpv = {
        enable = true;
        package = pkgs.mpv.override {
          mpv-unwrapped = pkgs.mpv-unwrapped.override {
            ffmpeg = pkgs.ffmpeg-full;
            bluraySupport = false;
            x11Support = false;
            waylandSupport = true;
            vdpauSupport = false;
          };
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
            thumbfast
            mpris
          ];
        };
        config = {
          vo = "gpu-next";
          gpu-api = "vulkan";
          hwdec = "vaapi";
          gpu-context = "waylandvk";
          ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
          video-sync = "display-resample";
          interpolation = "yes";
          tscale = "oversample";
          profile = "gpu-hq";
          scale = "ewa_lanczossharp";
          deband = "yes";
          osc = "no";
          osd-bar = "no";
          border = "no";
          save-position-on-quit = "yes";
        };
      };
    };
  };
}
