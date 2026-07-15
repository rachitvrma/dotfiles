{
  flake.nixosModules.dankMaterialShell = {
    services.displayManager = {
      dms-greeter = {
        enable = true;
        compositor = {
          name = "hyprland";
          customConfig = /* lua */ ''
            hl.config({
            	input = {
            		follow_mouse = 1,
            		kb_layout = "us",
            		kb_options = "caps:swapescape",
            		kb_variant = "colemak_dh",
            		numlock_by_default = true,
            		off_window_axis_events = 2,
            		repeat_delay = 250,
            		repeat_rate = 35,
            		sensitivity = 0,
            		touchpad = {
            			clickfinger_behavior = true,
            			disable_while_typing = true,
            			natural_scroll = true,
            			scroll_factor = 0.7,
            		},
            	},
            })
          '';
        };
      };
    };

    programs.dms-shell = {
      enable = true;
      systemd = {
        restartIfChanged = true;
      };
    };
  };
}
