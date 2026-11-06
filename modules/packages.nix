# System-wide packages. Program *configuration* lives in the topic modules
# (shell.nix, desktop.nix, services-user.nix, ...) and in stow/.
{
  flake.nixosModules.packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Media
        aria2
        yt-dlp
        (mpv.override {
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
        })
        cava
        swayimg
        wiremix
        zathura
        pinta

        # Documents
        pandoc
        libreoffice
        gelasio # font needed by LibreOffice

        # Apps
        equibop # FIXME: fix the autostart file somehow
        qutebrowser
        pcmanfm
        speedtest-cli
        timr-tui
        figlet
        sl

        # Theme stuff
        bibata-cursors
        nwg-look
        (gruvbox-plus-icons.override {
          folder-color = "purple";
        })
        # papirus-icon-theme
        gsettings-desktop-schemas
        glib
        adw-gtk3

        # Desktop plumbing
        kitty
        xdg-terminal-exec
        wl-clipboard
        shared-mime-info
        lxmenu-data
        ddcutil
        ddcutil-service
        ddcui

        # Files and disks
        trash-cli # see the trash-empty timer in services-user.nix
        jdupes
        gdu
        ntfsprogs
        file
        wget

        # System monitors
        bottom
        btop
        htop

        kdePackages.qt6ct
        libsForQt5.qt5ct

        # Android
        android-tools
        scrcpy

        # Browser
        firefox

        # Nix tooling
        nix-prefetch
        nix-prefetch-github
        nix-auth
        nix-search-tv # TODO: set it up
        nix-output-monitor
        nix-your-shell
        gitingest
        gitFull
        git-crypt

        # Secrets
        pass-wayland

        # pinentry packages
        pinentry-emacs

        # For user dirs
        xdg-user-dirs
        xdg-user-dirs-gtk
      ];

      environment.sessionVariables = {
        # Wayland hints that are safe in every session. Compositor-only
        # variables (SDL_VIDEODRIVER, QT_QPA_PLATFORM, GDK_BACKEND, ...) live in
        # stow/noctalia-stack/.../umbriel/config.toml, so X11 and TTY
        # sessions are not forced onto Wayland.
        NIXOS_OZONE_WL = 1;
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        MOZ_ENABLE_WAYLAND = 1;
        GTK_USE_PORTAL = 1;
      };

      programs = {
        nix-ld.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
        git = {
          enable = true;
          package = pkgs.gitFull;
          lfs.enable = true;
        };
        seahorse.enable = true;
      };

      # Use the system module for edge cases
      xdg.terminal-exec = {
        enable = true;
        settings.default = [ "kitty.desktop" ];
      };
    };
}
