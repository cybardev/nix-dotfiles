{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.cypkgs.modules.rift ];
  services.rift = {
    enable = false;
    package = pkgs.cy.rift;
    config = {
      settings = {
        animate = true;
        animation_duration = 0.3;
        animation_fps = 100.0;
        animation_easing = "ease_in_out";

        focus_follows_mouse = true;
        mouse_follows_focus = true;
        mouse_hides_on_focus = true;

        auto_focus_blacklist = [ ];

        run_on_start = [ ];

        hot_reload = true;

        layout = {
          mode = "bsp";

          stack = {
            stack_offset = 40.0;
            default_orientation = "perpendicular";
          };

          gaps = {
            outer = {
              top = 0;
              left = 0;
              bottom = 0;
              right = 0;
            };

            inner = {
              horizontal = 0;
              vertical = 0;
            };
          };
        };

        ui = {
          menu_bar = {
            enabled = true;
            show_empty = false;
            mode = "active";
            active_label = "name";
            display_style = "label";
          };

          stack_line = {
            enabled = false;
            horiz_placement = "top";
            vert_placement = "left";
            thickness = 0.0;
            spacing = 0.0;
          };

          mission_control = {
            enabled = false;
            fade_enabled = false;
            fade_duration_ms = 180.0;
          };
        };

        gestures = {
          enabled = false;
          invert_horizontal_swipe = false;
          swipe_vertical_tolerance = 0.4;
          skip_empty = true;
          fingers = 3;
          distance_pct = 0.08;
          haptics_enabled = true;
          haptic_pattern = "level_change";
        };

        window_snapping = {
          drag_swap_fraction = 0.3;
        };
      };

      virtual_workspaces = {
        enabled = true;
        default_workspace_count = 11;
        auto_assign_windows = true;
        preserve_focus_per_workspace = true;
        workspace_auto_back_and_forth = false;
        workspace_names = [
          "term"
          "1"
          "2"
          "3"
          "4"
          "5"
          "6"
          "7"
          "8"
          "9"
          "0"
        ];

        app_rules = [
          {
            title_substring = "Preferences";
            floating = true;
          }
          {
            app_name = "kitty";
            workspace = "term";
          }
          {
            app_name = "Firefox";
            workspace = 1;
          }
        ];
      };

      modifier_combinations = {
        # comb1 = "Alt + Shift";
      };

      keys =
        lib.genAttrs' (lib.map builtins.toString (lib.range 1 9)) (
          i: lib.nameValuePair "Alt + ${i}" { switch_to_workspace = i; }
        )
        // {
          "Alt + `" = {
            switch_to_workspace = "term";
          };
          "Alt + 0" = {
            switch_to_workspace = "10";
          };

          "Alt + H" = {
            move_focus = "left";
          };
          "Alt + J" = {
            move_focus = "down";
          };
          "Alt + K" = {
            move_focus = "up";
          };
          "Alt + L" = {
            move_focus = "right";
          };

          "Alt + Z" = "toggle_space_activated";
          "Alt + Tab" = "switch_to_last_workspace";

          "Alt + Shift + Left" = {
            join_window = "left";
          };
          "Alt + Shift + Right" = {
            join_window = "right";
          };
          "Alt + Shift + Up" = {
            join_window = "up";
          };
          "Alt + Shift + Down" = {
            join_window = "down";
          };
          # "Alt + Comma" = "toggle_stack";
          "Alt + Slash" = "toggle_orientation";
          "Alt + Ctrl + E" = "unjoin_windows";

          "Alt + Shift + Space" = "toggle_window_floating";
          "Alt + F" = "toggle_fullscreen";
          "Alt + Shift + F" = "toggle_fullscreen_within_gaps";
          "Alt + Shift + Ctrl + Space" = "toggle_focus_floating";

          "Alt + Shift + Equal" = "resize_window_grow";
          "Alt + Shift + Minus" = "resize_window_shrink";

          # "Alt + Shift + D" = "debug";
          # "Alt + Ctrl + S" = "serialize";
          # "Alt + Ctrl + Q" = "save_and_exit";
        };
    };
  };
}
