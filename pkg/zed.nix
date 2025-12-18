{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "clojure"
      "csharp"
      "dart"
      "dockerfile"
      "flutter-snippets"
      "git-firefly"
      "kanagawa-themes"
      "lua"
      "mcp-server-context7"
      "nix"
      "postgres-context-server"
      "pyrefly"
      "sql"
      "terraform"
      "typst"
      "warp-one-dark"
      "zed-docker-compose"
      "zed-mcp-server-supabase"
    ];
    userSettings = {
      auto_update = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      features = {
        edit_prediction_provider = "none";
      };
      edit_predictions = {
        mode = "subtle";
      };
      theme = {
        mode = "dark";
        dark = "Kanagawa Dragon";
        light = "Kanagawa Lotus";
      };
      buffer_font_family = "CaskaydiaCove Nerd Font";
      buffer_font_size = 13;

      vim_mode = true;
      helix_mode = true;
      cursor_blink = false;
      vim = {
        toggle_relative_line_numbers = true;
      };
      terminal = {
        dock = "right";
      };
      calls = {
        mute_on_join = true;
      };

      minimap = {
        show = "auto";
        thumb = "hover";
      };

      prettier = {
        tabWidth = 2;
        singleQuote = false;
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        Python = {
          language_servers = [
            "pyrefly"
            "!pyright"
            "!pylsp"
          ];
        };
        JavaScript = {
          prettier = {
            tabWidth = 4;
          };
        };
      };

      lsp = {
        nixd = {
          settings = {
            formatting = {
              command = [ "nixfmt" ];
            };
            diagnostics = {
              ignored = [ "sema-extra-with" ];
            };
          };
        };
        tinymist = {
          settings = {
            exportPdf = "onSave";
            outputPath = "$root/_preview/$name";
            formatterMode = "typstyle";
          };
        };
      };

      context_servers = {
        mcp-server-context7 = {
          enabled = true;
          source = "extension";
          settings = { };
        };
        postgres-context-server = {
          enabled = false;
          source = "extension";
          settings = {
            database_url = "http://localhost:54322";
          };
        };
      };

      agent = {
        enabled = true;
        enable_feedback = false;
        default_model = {
          provider = "lmstudio";
          model = "qwen/qwen3-4b-thinking-2507";
        };
        default_profile = "minimal";
        profiles = {
          create = {
            name = "Create";
            enable_all_context_servers = true;
            tools = {
              copy_path = true;
              create_directory = true;
              delete_path = true;
              diagnostics = true;
              edit_file = true;
              fetch = true;
              find_path = true;
              grep = true;
              list_directory = true;
              move_path = true;
              now = true;
              open = true;
              project_notifications = true;
              read_file = true;
              terminal = true;
              thinking = true;
              web_search = true;
            };
          };
        };
      };
    };
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "secondary-`" = "terminal_panel::Toggle";
          "secondary-b" = "workspace::ToggleRightDock";
          "secondary-alt-b" = "workspace::ToggleLeftDock";
          "secondary-alt-o" = [
            "agent::NewExternalAgentThread"
            {
              agent.custom = {
                name = "OpenCode";
                command = {
                  command = "opencode";
                  args = [ "acp" ];
                };
              };
            }
          ];
        };
      }
    ];
  };
}
