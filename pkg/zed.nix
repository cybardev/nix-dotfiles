{ lib, pkgs, ... }:
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
      "html-snippets"
      "java"
      "java-debug"
      "javascript-snippets"
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
      autosave.after_delay.milliseconds = 1000;

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
        nixd.settings = {
          formatting = {
            command = [ "nixfmt" ];
          };
          diagnostics = {
            ignored = [ "sema-extra-with" ];
          };
        };
        tinymist.settings = {
          exportPdf = "onSave";
          outputPath = "$root/_preview/$name";
          formatterMode = "typstyle";
        };
        jdtls.settings = {
          java_home = pkgs.zulu;
          lombok_support = true;
          jdk_auto_download = false;
          check_updates = "never";
          jdtls_launcher = lib.getExe pkgs.jdt-language-server;
          lombok_jar = "${pkgs.lombok}/share/java/lombok.jar";
        };
      };

      context_servers = {
        mcp-server-context7 = {
          enabled = true;
          settings = { };
        };
        postgres-context-server = {
          enabled = false;
          settings = {
            database_url = "http://localhost:54322";
          };
        };
      };

      language_models.lmstudio.available_models = [
        {
          name = "qwen2.5-coder-7b-instruct-mlx";
          display_name = "Qwen-Coder";
          max_tokens = 32768;
          supports_tool_calls = true;
          supports_thinking = false;
          supports_images = false;
        }
      ];

      agent = {
        enabled = true;
        enable_feedback = false;
        default_model = {
          provider = "lmstudio";
          model = "qwen2.5-coder-7b-instruct-mlx";
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
          "secondary-alt-o" = "agent::ToggleFocus";
        };
      }
    ];
  };
}
