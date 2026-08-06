# zk is a tool for managing notes in terminal
{
  flake.homeModules.zk = { config, ... }: {
    programs = {
      zk = {
        enable = true;
        settings = {
          notebook.dir = "${config.home.homeDirectory}/Notes"; # match XDG_NOTES_DIR
          note = {
            language = "en";
            default-title = "Untitled";
            filename = "{{id}}-{{slug title}}";
            extension = "md";
            id-charset = "alphanum";
            id-length = 4;
            id-case = "lower";
          };
          group = {
            daily = {
              paths = [ "journal/daily" ];
              note = {
                filename = "{{format-date now}}";
                extension = "md";
                template = "daily.md";
              };
            };
          };
          format.markdown = {
            hashtags = true;
            colon-tags = true;
          };
          tool = {
            editor = "nvim";
            fzf-preview = "bat -p --color always {-1}";
          };
          alias = {
            edit = ''zk edit --interactive "$@"'';
            ls = ''zk list "$@"'';
            ed = ''zk edit "$@"'';
            n = ''zk new "$@"'';
            nt = ''zk new --title "$*"'';
            daily = ''zk new --no-input "$ZK_NOTEBOOK_DIR/journal/daily"'';
          };
        };
      };
    };
    home.sessionVariables = {
      # Use the $XDG_NOTES_DIR as the ZK_NOTEBOOK_DIR
      ZK_NOTEBOOK_DIR = config.xdg.userDirs.extraConfig.NOTES;
    };
  };
}
