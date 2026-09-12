{
  flake.homeModules.mpv = { pkgs, ... }: {
    # For videos/music
    programs.mpv = {
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
          autoload
          eisa01.smartskip
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
        input-ipc-server = "/tmp/mpv.sock";
        # ytdl-raw-options = ''cookies-from-browser=firefox,extractor-args="youtube:player_client=mweb"'';
      };
    };
  };
}
