{
  flake.nixosModules.theme_n_fonts =
    { pkgs, ... }:
    {
      gtk.iconCache.enable = true;
      qt.enable = true;

      fonts = {
        # Needed so symbols-only Nerd Font etc. are picked up as fallbacks.
        packages = with pkgs; [
          nerd-fonts.symbols-only
          nerd-fonts.jetbrains-mono
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji
          cantarell-fonts
        ];

        fontDir.enable = true;

        # Same family names as stow/fontconfig/.../52-default-fonts.conf, so
        # the system and the user config no longer disagree.
        fontconfig = {
          enable = true;
          defaultFonts = {
            monospace = [ "JetBrainsMono Nerd Font" ];
            serif = [ "JetBrainsMono Nerd Font" ];
            sansSerif = [ "JetBrainsMono Nerd Font" ];
            emoji = [ "Noto Color Emoji" ];
          };
        };
      };
    };
}
