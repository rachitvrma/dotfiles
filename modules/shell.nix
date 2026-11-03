# Shell programs. Their *configuration and shell hooks* (zoxide, direnv,
# starship, television, vivid, ...) come from stow/bash and stow/fish, so the
# NixOS integrations are turned off to avoid initialising everything twice.
{
  flake.nixosModules.shell =
    { pkgs, ... }:
    {
      environment.shellAliases = {
        rm = "rm -i"; # use \rm -rf for removing a large dir or files without confirmation
        cp = "cp -i";
        mv = "mv -i";

        # These are set by default.
        # Read the source code of environment.shellAliases block.
        ls = null;
        ll = null;
        l = null;
      };

      environment.pathsToLink = [ "/share/bash-completion" ];

      environment.systemPackages = with pkgs; [
        starship
        zoxide
        television
        vivid
        fzf
        pay-respects
        carapace
        tealdeer
        fastfetch
        eza
        fd
        ripgrep

        # Fish plugins
        fishPlugins.done
        fishPlugins.fzf-fish
      ];

      programs = {
        bash.completion.enable = true;
        fish = {
          enable = true;
          useBabelfish = true;
          generateCompletions = true;
          vendor = {
            config.enable = true;
            functions.enable = true;
            completions.enable = true;
          };
        };
        bat.enable = true; # config: stow/bat

        direnv = {
          enable = true;
          nix-direnv.enable = true;
          enableBashIntegration = false; # stow/bash/dot-bashrc.d/90-init.bashrc
          enableFishIntegration = false; # stow/fish/dot-config/fish/conf.d/90-init.fish
          # config: stow/direnv
        };
      };

      security.sudo = {
        enable = true;
        execWheelOnly = true;
        package = pkgs.sudo.override { withInsults = true; };
        extraConfig = ''
          Defaults pwfeedback
        '';
      };
    };
}
