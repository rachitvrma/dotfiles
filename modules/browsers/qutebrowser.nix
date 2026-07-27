{ self, ... }: {
  flake.overlays.qutebrowser = final: prev: {
    qutebrowser = prev.qutebrowser.override {
      enableWideVine = true;
      enableVulkan = true;
      withPdfReader = false;
    };
  };

  flake.nixosModules.qutebrowser = {
    nixpkgs.overlays = [ self.overlays.qutebrowser ];
  };

  flake.homeModules.qutebrowser = { pkgs, ... }: {
    programs.qutebrowser =
      let
        userscript_dir = pkgs.qutebrowser + "/share/qutebrowser/userscripts";
      in
      {
        enable = true;
        settings = {
          downloads = {
            position = "bottom";
          };
          editor = {
            command = [
              "nvim"
              "-f"
              "{file}"
              "-c"
              "normal {line}G{column0}l"
            ];
          };
          fileselect = {
            folder.command = [
              "kitty"
              "--class"
              "filechoose_yazi"
              "-e"
              "yazi"
              "--chooser-file={}"
            ];
            single_file.command = [
              "kitty"
              "--class"
              "filechoose_yazi"
              "-e"
              "yazi"
              "--chooser-file={}"
            ];
            multiple_files.command = [
              "kitty"
              "--class"
              "filechoose_yazi"
              "-e"
              "yazi"
              "--chooser-file={}"
            ];
          };
          fonts = {
            default_family = "monospace";
            web.family = {
              sans_serif = "monospace";
              serif = "monospace";
            };
          };
          content.javascript.enabled = true;
          colors.webpage = {
            darkmode.enabled = true;
            preferred_color_scheme = "dark";
          };
        };
        aliases = {
          mpv = "spawn --userscript ${userscript_dir}/view_in_mpv";
        };

        extraConfig = builtins.readFile ./qutebrowser.py;
      };
  };
}
