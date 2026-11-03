{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  strange = first: last: (map toString (lib.range first last));
  strangeAttrs = lib.genAttrs' (strange 1 9);

  wsRules =
    ws-start: ws-end: display:
    map (ws: {
      workspace = ws;
      display = [
        display
        "builtin"
      ];
    }) (lib.range ws-start ws-end);

  appRules =
    rules:
    lib.concatLists (
      lib.mapAttrsToList (
        ws: apps:
        (map (app: {
          app_name = app;
          workspace = ws;
        }) apps)
      ) rules
    );
in
{
  imports = [ inputs.cypkgs.modules.rift ];
  services.rift = {
    enable = true;
    package = pkgs.cy.rift-wm;
    config = {
      settings = {
        default_disable = false;
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

        drag_drop = {
          drop_action = "swap";
          drop_zone_fraction = 0.25;
        };
      };

      virtual_workspaces = {
        enabled = true;
        mode = "global";
        default_workspace = 1;
        default_workspace_count = 11;
        auto_assign_windows = true;
        preserve_focus_per_workspace = true;
        workspace_auto_back_and_forth = false;
        workspace_names = [ "T" ] ++ (strange 1 9) ++ [ "0" ];
        workspace_rules = (wsRules 0 5 "top") ++ (wsRules 6 10 "bottom");
        app_rules = [
          {
            title_substring = "Preferences";
            floating = true;
          }
        ]
        ++ (appRules {
          "T" = [
            "kitty"
            "Terminal"
          ];
          "1" = [
            "Firefox"
            "Helium"
          ];
          "2" = [
            "Finder"
          ];
          "0" = [
            "Zed"
          ];
        });
      };

      modifier_combinations = {
        ModCombo = "Alt + Shift";
      };

      keys =
        (strangeAttrs (i: lib.nameValuePair "Alt + ${i}" { switch_to_workspace = i; }))
        // (strangeAttrs (i: lib.nameValuePair "ModCombo + ${i}" { move_window_to_workspace = i; }))
        // {
          "Alt + `" = {
            switch_to_workspace = "T";
          };
          "Alt + 0" = {
            switch_to_workspace = "0";
          };
          "ModCombo + `" = {
            move_window_to_workspace = "T";
          };
          "ModCombo + 0" = {
            move_window_to_workspace = "0";
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

          "Alt + Tab" = "switch_to_last_workspace";

          # "Alt + Comma" = "toggle_stack";
          "Alt + Slash" = "toggle_orientation";

          "ModCombo + Space" = "toggle_window_floating";
          "Alt + F" = "toggle_fullscreen";
          "ModCombo + F" = "toggle_fullscreen_within_gaps";
          "ModCombo + Ctrl + Space" = "toggle_focus_floating";

          "ModCombo + Equal" = "resize_window_grow";
          "ModCombo + Minus" = "resize_window_shrink";

          # "ModCombo + D" = "debug";
          # "Alt + Ctrl + S" = "serialize";
          # "Alt + Ctrl + Q" = "save_and_exit";
        };
    };
  };
}
