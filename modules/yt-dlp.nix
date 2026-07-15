# NOTE: Download music from youtube music (music.youtube.com) for better metadata and tagging
{
  flake.homeModules.yt-dlp = { pkgs, ... }: {
    home.packages = [
      (pkgs.writeShellScriptBin "yt-music" ''
        set -euo pipefail

        command -v yt-dlp >/dev/null || {
            printf '%s\n' "yt-dlp is not installed." >&2
            exit 1
        }

        download_dir="$HOME/Downloads/Music"
        archive_file="$HOME/.local/share/yt-dlp/music-archive.txt"

        mkdir -p \
            "$download_dir" \
            "$(dirname "$archive_file")"

        exec yt-dlp \
          --extract-audio \
          --audio-format opus \
          --format ba/b \
          --paths "$download_dir" \
          --metadata-from-title "%(artist)s - %(title)s" \
          --output "%(channel|Unknown Channel)s/%(upload_date>%Y-%m-%d)s - %(title)s.%(ext)s" \
          --download-archive "$archive_file" \
          "$@"
      '')

      (pkgs.writeShellScriptBin "yt-playlist" ''
        set -euo pipefail

        if ! command -v yt-dlp &>/dev/null; then
          echo "yt-dlp is not installed"
          echo "Install yt-dlp first"
          exit 1
        fi

        yt-dlp \
          --ignore-errors \
          --continue \
          --no-overwrites \
          --download-archive \
          progress.txt \
          "$@"
      '')
    ];
    programs.yt-dlp = {
      enable = true;
      settings = {
        color = [
          "stdout:no_color"
          "stderr:always"
        ];
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -j 3 -x8 -s8 -k1M --async-dns=false'";
        # embed-subs = true;
        embed-thumbnail = true;
        embed-metadata = true;
        format = "bestvideo+bestaudio/best";
        continue = true;
        restrict-filenames = true;
        ignore-errors = true;
        # sub-langs = "all,-live_chat";
      };
    };
  };
}
