# zk is a tool for managing notes in terminal
{
  flake.homeModules.zk = { config, ... }: {
    xdg.configFile."zk/templates/default.md".source = ./templates/default.md;

    programs = {
      zk = {
        enable = true;
        exportNotebookDir = true;
        settings = {
          alias = {
            ed = "zk edit \"$@\"";
            edit = "zk edit --interactive \"$@\"";
            ls = "zk list \"$@\"";
            n = "zk new \"$@\"";
            nt = "zk new --title \"$*\"";
          };
          format = {
            markdown = {
              colon-tags = true;
              frontmatter = {
                creation-date-key = "created";
                modification-date-key = "changed";
              };
              hashtags = true;
              multiword-tags = true;
            };
          };
          note = {
            default-title = "Untitled";
            extension = "md";
            filename = "{{id}}-{{slug title}}";
            id-case = "lower";
            id-charset = "alphanum";
            id-length = 4;
            language = "en";
            template = "default.md";
          };
          notebook = {
            dir = config.home.homeDirectory + "/Notes";
          };
          tool = {
            editor = "nvim";
            fzf-preview = "bat -p --color always {-1}";
          };
        };
      };
    };
  };
}
