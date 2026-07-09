{
  flake.nixosModules.irc = {
    services.weechat = {
      enable = true;
    };

    programs.screen.screenrc = ''
      multiuser on
      acladd krish
      term screen-256color
    '';
  };

  flake.homeModules.irc = { pkgs, ... }: {
    home.packages = with pkgs; [ weechat ];
    programs.screen = {
      enable = true;
      screenrc = ''
        multiuser on
        acladd krish
        term screen-256color
      '';
    };
  };
}
