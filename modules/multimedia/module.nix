{
  flake.homeModules.multimedia =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      # These are fixes that help make rmpc, mpd, mpdris2-rs work.
      systemd.user.services = {
        # Without this the socket file is not created correctly.
        # Since I am using a systemd-service instead of a systemd-socket
        # to create a socket file.
        # NOTE: fix this in the source module.
        mpd.Service.ExecStartPre = lib.mkForce [
          "${pkgs.coreutils}/bin/mkdir -p ${config.services.mpd.dataDir}"
          "${pkgs.coreutils}/bin/mkdir -p ${config.services.mpd.playlistDirectory}"
          "${pkgs.coreutils}/bin/mkdir -p %t/mpd"
        ];
        mpdris2-rs = {
          Service.TimeoutStartSec = "10s";
          Unit = {
            After = [ "graphical-session.target" ]; # mpdris2-rs starts before grahphical-session
            PartOf = [ "graphical-session.target" ]; # which makes it receive SIGTERM by dbus tools like noctalia
          };
        };
      };

      home = {
        packages = with pkgs; [
          ffmpeg-full
          mpc
          (python3.withPackages (ps: with ps; [ mutagen ])) # used for album art embedding
        ];
      };

      # RMPC's lyrics fetching script.
      # NOTE: This won't be needed once RMPCD is released.
      xdg = {
        configFile = {
          "mpd/mpd.conf".text = config.services.mpd.generatedConfig;
          "rmpc/fetch-lyrics".source = pkgs.writeShellScript "fetch-lyrics" ''
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

          # TODO: Write a rmpc theme module
          "rmpc/theme.ron".source = ./rmpc_config/theme.ron;
        };
      };

      services = {
        mpd = {
          enable = true;
          musicDirectory = "${config.xdg.userDirs.music}";
          enableSessionVariables = true;
          network = {
            startWhenNeeded = false; # Don't use the systemd-socket, but the service only
            listenAddress = "$XDG_RUNTIME_DIR/mpd/socket";
          };
          extraConfig = ''
            audio_output {
              type "pipewire"
              name "PipeWire"
            }

            audio_output {
              type "fifo"
              name "my_fifo"
              path "/tmp/mpd.fifo"
              format "44100:16:2"
            }
          '';
        };
        mpdris2-rs = {
          enable = true;
          # The default for host is MPD_HOST, which in my config is $XDG_RUNTIME_DIR/mpd/socket
          host = "%t/mpd/socket";
          notifications.enable = true;
        };
      };

      programs = {
        rmpc = {
          enable = true;
          config = builtins.readFile ./rmpc_config/config.ron;
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
            mpdIntegration = {
              enableUpdate = true;
              enableStats = true;
              host = config.services.mpd.network.listenAddress;
            };
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
