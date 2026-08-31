{
  flake.homeModules.glow = { config, ... }: {
    programs.glow = {
      enable = true;
      settings = {
        style = "${config.xdg.configHome}/glow/styles/stylix.json";
        mosue = false;
        pager = false;
        width = 80;
        all = false;
        showLineNumbers = false;
        preserveNewLines = false;
      };
      styles = with config.lib.stylix.colors.withHashtag; {
        stylix = {
          document = {
            block_prefix = "\n";
            block_suffix = "\n";
            color = base05;
            margin = 2;
          };
          block_quote = {
            indent = 1;
            indent_token = "│ ";
          };
          paragraph = { };
          list = {
            level_indent = 2;
          };
          heading = {
            block_suffix = "\n";
            color = base0D;
            bold = true;
          };
          h1 = {
            prefix = " ";
            suffix = " ";
            color = base00;
            background_color = base0E;
            bold = true;
          };
          h2 = {
            prefix = "## ";
          };
          h3 = {
            prefix = "### ";
          };
          h4 = {
            prefix = "#### ";
          };
          h5 = {
            prefix = "##### ";
          };
          h6 = {
            prefix = "###### ";
            color = base0B;
            bold = false;
          };
          text = { };
          strikethrough = {
            crossed_out = true;
          };
          emph = {
            italic = true;
          };
          strong = {
            bold = true;
          };
          hr = {
            color = base03;
            format = "\n--------\n";
          };
          item = {
            block_prefix = "• ";
          };
          enumeration = {
            block_prefix = ". ";
          };
          task = {
            ticked = "[✓] ";
            unticked = "[ ] ";
          };
          link = {
            color = base0C;
            underline = true;
          };
          link_text = {
            color = base0E;
            bold = true;
          };
          image = {
            color = base0E;
            underline = true;
          };
          image_text = {
            color = base04;
            format = "Image: {{.text}} →";
          };
          code = {
            prefix = " ";
            suffix = " ";
            color = base08;
            background_color = base01;
          };
          code_block = {
            color = base04;
            margin = 2;
            chroma = {
              text = {
                color = base05;
              };
              error = {
                color = base00;
                background_color = base08;
              };
              comment = {
                color = base03;
              };
              comment_preproc = {
                color = base09;
              };
              keyword = {
                color = base0D;
              };
              keyword_reserved = {
                color = base0E;
              };
              keyword_namespace = {
                color = base08;
              };
              keyword_type = {
                color = base0C;
              };
              operator = {
                color = base08;
              };
              punctuation = {
                color = base0A;
              };
              name = {
                color = base05;
              };
              name_builtin = {
                color = base0E;
              };
              name_tag = {
                color = base0C;
              };
              name_attribute = {
                color = base0D;
              };
              name_class = {
                color = base06;
                underline = true;
                bold = true;
              };
              name_constant = { };
              name_decorator = {
                color = base0A;
              };
              name_exception = { };
              name_function = {
                color = base0B;
              };
              name_other = { };
              literal = { };
              literal_number = {
                color = base0C;
              };
              literal_date = { };
              literal_string = {
                color = base09;
              };
              literal_string_escape = {
                color = base0B;
              };
              generic_deleted = {
                color = base08;
              };
              generic_emph = {
                italic = true;
              };
              generic_inserted = {
                color = base0B;
              };
              generic_strong = {
                bold = true;
              };
              generic_subheading = {
                color = base03;
              };
              background = {
                background_color = base01;
              };
            };
          };
          table = { };
          definition_list = { };
          definition_term = { };
          definition_description = {
            block_prefix = "\n🠶 ";
          };
          html_block = { };
          html_span = { };
        };
      };
    };
  };
}
