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
          max-upload-limit = "50K";

          ## ── Disk ─────────────────────────────────────────────────────
          # falloc is best on ext4/xfs/btrfs — change to trunc on FAT/NTFS
          file-allocation = "falloc";
          enable-mmap = true;
          disk-cache = "64M";

          ## ── RPC ──────────────────────────────────────────────────────
          enable-rpc = true;
          rpc-listen-port = 6800;
          rpc-allow-origin-all = true;
          # rpc-listen-all=false means localhost only (safer, fine for local clients)
          # flip to true only if you need LAN access from another device
          rpc-listen-all = false;
          # rpc-secret=CHANGE_ME   ← uncomment if you ever expose this on LAN

          ## ── BitTorrent ───────────────────────────────────────────────
          follow-torrent = true;
          listen-port = 60000;
          dht-listen-port = 60000;
          disable-ipv6 = true;
          bt-max-peers = 55;
          enable-dht = false;
          bt-enable-lpd = false;
          enable-peer-exchange = false;
          seed-ratio = 0.0;
          bt-hash-check-seed = true;
          bt-seed-unverified = true;
          bt-save-metadata = true;
          bt-require-crypto = true;
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
