{
  flake.homeModules.aria2 = { pkgs, config, ... }: {
    home.packages = with pkgs; [ libnotify ];
    programs = {
      aria2p = {
        enable = true;
      };
      aria2 = {
        enable = true;
        systemd.enable = true;
        settings = {
          ## ── Core ─────────────────────────────────────────────────────
          dir = "${config.xdg.userDirs.download}";
          continue = true;
          input-file = "${config.xdg.configHome}/aria2/session.lock";
          save-session = "${config.xdg.configHome}/aria2/session.lock";
          save-session-interval = 30;
          force-save = false;

          ## ── Connections ──────────────────────────────────────────────
          max-concurrent-downloads = 5;
          max-connection-per-server = 16;
          split = 16;
          min-split-size = "1M";
          max-tries = 5;
          retry-wait = 0;
          lowest-speed-limit = 0;
          enable-http-pipelining = true;
          async-dns = false;

          ## ── Speed limits ─────────────────────────────────────────────
          max-overall-download-limit = 0;
          max-download-limit = 0;
          max-overall-upload-limit = 0;
          max-upload-limit = "500K";

          ## ── Disk ─────────────────────────────────────────────────────
          file-allocation = "falloc";
          enable-mmap = true;
          disk-cache = "128M";

          ## ── RPC ──────────────────────────────────────────────────────
          enable-rpc = true;
          rpc-listen-port = 6800;
          rpc-allow-origin-all = true;
          rpc-listen-all = false;

          ## ── BitTorrent ───────────────────────────────────────────────
          follow-torrent = true;
          listen-port = 60000;
          dht-listen-port = 60000;
          disable-ipv6 = true;
          bt-max-peers = 0;
          enable-dht = true;
          bt-enable-lpd = true;
          enable-peer-exchange = true;
          seed-ratio = 0.0;
          bt-hash-check-seed = true;
          bt-seed-unverified = true;
          bt-save-metadata = true;
          bt-require-crypto = true;
          bt-tracker = "udp://tracker.opentrackr.org:1337/announce,udp://open.stealth.si:80/announce,udp://tracker.torrent.eu.org:451/announce";
          ftp-pasv = true;

          # Transmission spoof for private tracker compatibility
          peer-id-prefix = "-TR2770-";
          user-agent = "Transmission/2.77";

          ## ── Notifications (requires libnotify) ───────────────────────
          on-download-complete = "notify-send 'aria2' 'Download complete'";
          on-download-error = "notify-send 'aria2' 'Download failed'";
          on-download-pause = "notify-send 'aria2' 'Download paused'";
          on-download-start = "notify-send 'aria2' 'Download started'";
          on-bt-download-complete = "notify-send 'aria2' 'Torrent complete'";
        };
      };
    };

    systemd.user.services = {
      aria2 = {
        Service = {
          # The order of the commands in this list matters
          ExecStartPre = [
            "${pkgs.coreutils-full}/bin/touch %h/.config/aria2/session.lock"
            "${pkgs.coreutils-full}/bin/mkdir -p %h/.config/aria2"
          ];
        };
      };
    };
  };
}
