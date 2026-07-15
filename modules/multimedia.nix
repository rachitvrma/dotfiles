{
  flake.homeModules.multimedia = { pkgs, config, ... }: {
    home = {
      packages = with pkgs; [
        ffmpeg-full
        # used for album art embedding
        (python3.withPackages (ps: with ps; [ mutagen ]))
      ];
      # Use socket for MPD connection, otherwise RMPC doesn't allow youtube playback.
      sessionVariables.MPD_HOST = "$XDG_RUNTIME_DIR/mpd/socket";
    };

    # RMPC's lyrics fetching script.
    # NOTE: This won't be needed once RMPCD is released.
    xdg.configFile."rmpc/fetch-lyrics".source = pkgs.writeShellScript "fetch-lyrics" ''
      set -euo pipefail
      LRCLIB_INSTANCE="https://lrclib.net"
      rmpc="${config.programs.rmpc.package}/bin/rmpc"
      jq="${pkgs.jq}/bin/jq"

      if [ "$HAS_LRC" = "false" ]; then
        mkdir -p "$(dirname "$LRC_FILE")"

        response="$(${pkgs.curl}/bin/curl -sG \
          -H "Lrclib-Client: rmpc-$VERSION" \
          --data-urlencode "artist_name=$ARTIST" \
          --data-urlencode "track_name=$TITLE" \
          --data-urlencode "album_name=''${ALBUM:-}" \
          "$LRCLIB_INSTANCE/api/get" || true)"

        if ! lyrics="$(printf '%s' "$response" | "$jq" -er '.syncedLyrics // empty' 2>/dev/null)"; then
          "$rmpc" remote --pid "$PID" status "No lyrics found for $ARTIST - $TITLE" --level warn
          exit 0
        fi

        if [ -z "$lyrics" ]; then
          "$rmpc" remote --pid "$PID" status "No lyrics found for $ARTIST - $TITLE" --level warn
          exit 0
        fi

        {
          echo "[ar:$ARTIST]"
          echo "[al:''${ALBUM:-}]"
          echo "[ti:$TITLE]"
          echo "$lyrics"
        } > "$LRC_FILE"

        "$rmpc" remote --pid "$PID" indexlrc --path "$LRC_FILE"
        "$rmpc" remote --pid "$PID" status "Downloaded lyrics for $ARTIST - $TITLE" --level info
      fi
    '';

    services = {
      mpd = {
        enable = true;
        musicDirectory = "${config.xdg.userDirs.music}";
        enableSessionVariables = false;
        network.startWhenNeeded = true;
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire"
          }
        '';
      };
      mpdris2-rs = {
        enable = true;
        notifications.enable = true;
      };
    };
    programs = {
      # For TUI music
      # Put this to download lyrics
      rmpc = {
        enable = true;
        config = /* ron */ ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]

          (
            address: "/run/user/1000/mpd/socket",
            cache_dir: Some("${config.xdg.cacheHome}/rmpc"),
            lyrics_dir: Some("${config.xdg.dataHome}/rmpc/lyrics"),
            enable_lyrics_hot_reload: true,
            on_song_change: ["${config.xdg.configHome}/rmpc/fetch-lyrics"],
          )
        '';
      };
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
        mpdIntegration = {
          enableUpdate = true;
          enableStats = true;
          host = config.services.mpd.network.listenAddress;
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
