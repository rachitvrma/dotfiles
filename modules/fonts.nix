{
  flake.nixosModules.font = { pkgs, ... }: {
    fonts = {
      fontconfig = {
        enable = true;
        includeUserConf = true;

        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [
            "JetBrainsMono Nerd Font Mono"
            "Noto Sans Mono"
          ];
          sansSerif = [
            "JetBrainsMono Nerd Font"
            "Noto Sans"
          ];
          serif = [
            "JetBrainsMono Nerd Font"
            "Noto Serif"
          ];
        };
      };

      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji

        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
      ];
    };

  };

  flake.homeModules.font = {
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [
            "JetBrainsMono Nerd Font Mono"
            "Noto Sans Mono"
          ];
          sansSerif = [
            "JetBrainsMono Nerd Font"
            "Noto Sans"
          ];
          serif = [
            "JetBrainsMono Nerd Font"
            "Noto Serif"
          ];
        };
      };
    };
  };
}
