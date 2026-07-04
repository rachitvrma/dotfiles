{
  flake.homeModules.yt-dlp = { pkgs, ... }: {
    home.packages = [
      (pkgs.writeShellScriptBin "yt-music" ''
        set -euo pipefail

        if ! command -v yt-dlp &>/dev/null; then
          echo "yt-dlp is not installed"
          echo "install yt-dlp first"
          exit 1
        fi

        yt-dlp \
          -f bestaudio \
          -x \
          --audio-format best \
          -P "$HOME/Music" \
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
        embed-subs = true;
        embed-thumbnail = true;
        embed-metadata = true;
        format = "bestvideo+bestaudio/best";
        sub-langs = "all,-live_chat";
      };
    };
  };
}
